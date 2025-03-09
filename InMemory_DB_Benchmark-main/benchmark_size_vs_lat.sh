#!/bin/bash

databases=("redis" "memcached" "postgresql")
workloads=("a" "b" "f")
recordcounts=(1000 10000 100000 500000)

for db in "${databases[@]}"; do

    for recordcount in "${recordcounts[@]}"; do
        for workload in "${workloads[@]}"; do
    
            if [[ $db == "postgresql" ]]; then
                # clear data
                PGPASSWORD=ycsb_user psql -U ycsb_user -h localhost -d ycsb_db -c "TRUNCATE TABLE usertable"

                # load workload
                bin/ycsb load jdbc -P jdbc-binding/conf/db.properties -P workloads/workload$workload -p recordcount=$recordcount > "results/load2/load_${db}_${recordcount}_workload${workload}.txt"

                # run workload
                bin/ycsb run jdbc -P jdbc-binding/conf/db.properties -P workloads/workload$workload -p recordcount=$recordcount > "results/run2/run_${db}_${recordcount}_workload${workload}.txt"
                
            elif [[ $db == "memcached" ]]; then
                # clear data
                echo "flush_all" | nc -q 1 localhost 11211

                # load workload
                bin/ycsb load memcached -s -P workloads/workload$workload -p memcached.hosts=localhost -p recordcount=$recordcount > "results/load2/load_memcached_${recordcount}_workload${workload}.txt"
                
                # run workload
                bin/ycsb run memcached -s -P workloads/workload$workload -p memcached.hosts=localhost -p recordcount=$recordcount > "results/run2/run_memcached_${recordcount}_workload${workload}.txt"

            elif [[ $db == "redis" ]]; then
                # clear data
                redis-cli FLUSHALL

                # load workload
                bin/ycsb load redis -s -P workloads/workload$workload -p redis.host=localhost -p recordcount=$recordcount > "results/load2/load_redis_${recordcount}_workload${workload}.txt"

                # run workload
                bin/ycsb run redis -s -P workloads/workload$workload -p redis.host=localhost -p recordcount=$recordcount > "results/run2/run_redis_${recordcount}_workload${workload}.txt"

            else
                echo "Error: Unknown database: $db"
            fi
        done
    done
done


