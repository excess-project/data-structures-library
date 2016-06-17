// EXCESS Data structure library test program
// Anders Gidenstam

#include <iostream>

#include <omp.h>

#include <EXCESS/concurrent_queue>

// Prepare the types for a queue storing int* pointers.
typedef excess::concurrent_queue<int> concurrent_queue_t;
typedef excess::concurrent_queue<int>::handle handle_t;

static void queue_test(int queue_to_use); 

int main(int argc, char** argv)
{
  std::cout << "Testing EXCESS:concurrent_queue component..." << std::endl;
#ifdef USE_TBB
  queue_test(7);
#else
  queue_test(0);
#endif
  std::cout << "done." << std::endl;

  return 0;
}


static void queue_test(int queue_to_use)
{
  concurrent_queue_t* queue;

  switch (queue_to_use) {
  case 7:
#ifdef USE_TBB
    // The concurrent_queue from Intel Threading Building Blocks.
    queue = new excess::concurrent_queue_TBBQueue<int>();
#endif
    break;
  default:
    // An implementation of the Michael and Scott two-lock queue.
    queue = new excess::concurrent_queue_MSTLB<int>();
  }
#pragma omp parallel
  {
    // Register this thread with the concurrent queue (e.g. for memory
    // management). It is more efficient to do this explicitly rather than
    // checking some thread local variable internally on every call.
    handle_t* queue_handle = queue->get_handle();

    int thread_id = omp_get_thread_num();

    for (int i = 0; i < 100; ++i) {
      queue_handle->enqueue(new int(10000*(thread_id +1)+ i));
    }
    int* tmp;
    while (queue_handle->try_dequeue(tmp)) {
      std::cout << "Got '" << *tmp << "'." << std::endl;
      delete tmp;
    } // Exit when the queue is empty.
    // Deregister this thread from the queue.
    delete queue_handle;
  } // end of #pragma omp parallel
  delete queue;
}

