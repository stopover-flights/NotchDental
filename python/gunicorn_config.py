import multiprocessing

max_requests = 500

log_file = "-"

workers = multiprocessing.cpu_count() * 2 + 1