# In-Memory databases:Redis vs Memcached Performance Evaluation

## Overview
This study aims to evaluate and compare the performance of two popular in-memory databases, **Redis** and **Memcached**. By conducting two benchmarks under different conditions, we highlight the strengths and weaknesses of these databases and offer recommendations based on the results. The focus of this project is on evaluating the performance of Redis and Memcached, particularly in the context of handling high-traffic websites and supporting analytical dashboards.

## Objective
The primary objective of this study was to assess the performance of Redis and Memcached and to make recommendations based on their strengths and weaknesses in different scenarios. The benchmarks focused on read and insert operations, two crucial aspects of in-memory database performance.

## Benchmarks

### 1. **YCSB Benchmark**
We used the automated **YCSB (Yahoo! Cloud Serving Benchmark)** tool to compare the performance of Redis and Memcached. This tool provided valuable insights into:

- **Redis**: Demonstrated faster read operations compared to Memcached.
- **Memcached**: Excelled at inserting new data into the database.

Both databases were found to be significantly faster than PostgreSQL, highlighting their efficiency as in-memory data stores.

### 2. **HTTP Requests Benchmark**
In the second benchmark, we used a dataset simulating HTTP requests in a database environment designed for an analytical dashboard to analyze website traffic. Key findings include:

- **Memcached**: Outperformed Redis in insertion operations, making it ideal for handling high-traffic websites.
- **Redis**: Performed better in interacting with already-stored data, making it more efficient for read-heavy applications.

These results align with previous studies (Kabakus et al., 2017), lending credibility to our observations.

## Recommendations
Based on the benchmarks, we recommend **Memcached** for use in environments like analytical dashboards, especially in cases where efficient data insertion is critical. Memcached's superior performance in insertion operations makes it particularly suitable for high-traffic websites with large volumes of incoming data.

### Key Considerations:
- **Redis**: Best for scenarios requiring fast read operations and efficient interaction with already-stored data.
- **Memcached**: Optimal for use cases where inserting large volumes of data quickly is essential.

## Future Work
While this study provides a solid foundation for choosing between Redis and Memcached, further testing is needed to fully understand their capabilities and trade-offs. Future benchmarks could focus on the following aspects:

- **Memory Efficiency**: Since both Redis and Memcached rely on RAM for storage, testing their memory efficiency is essential for understanding their limitations.
- **Application-Specific Performance**: Evaluating these technologies in a real-world application environment with queries tailored to specific application needs would provide deeper insights into their performance.

## Conclusion
This project provides valuable insights into the performance of Redis and Memcached, helping developers and engineers make informed decisions when choosing an in-memory database. However, continued research and testing are necessary to fully understand the trade-offs and to explore other performance metrics.
