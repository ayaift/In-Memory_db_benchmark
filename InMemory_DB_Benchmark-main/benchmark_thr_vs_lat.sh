#!/bin/bash


databases=("redis" "memcached" "postgresql")
workloads=("a" "b" "f")
throughputs=(1000 3000 5000)

recordcount=100000
operationcount=100000

for db in "${databases[@]}"; do

    # ----------------------- Load Data -----------------------
    if [[ $db == "postgresql" ]]; then
        # clear data
        PGPASSWORD=ycsb_user psql -U ycsb_user -h localhost -d ycsb_db -c "TRUNCATE TABLE usertable"
        # load workload
        bin/ycsb load jdbc -s -P jdbc-binding/conf/db.properties -P workloads/workloada -p recordcount=$recordcount

    elif [[ $db == "memcached" ]]; then
            # clear data
            echo "flush_all" | nc -q 1 localhost 11211
            # load workload
            bin/ycsb load memcached -s -P workloads/workloada -p memcached.hosts=localhost -p recordcount=$recordcount

     elif [[ $db == "redis" ]]; then
        # clear data
        redis-cli FLUSHALL
        # load workload
        bin/ycsb load redis -s -P workloads/workloada -p redis.host=localhost -p recordcount=$recordcount
    fi

    # ----------------------- Run Throughputs -----------------------
    for workload in "${workloads[@]}"; do

        if [[ $db == "postgresql" ]]; then
            for throughput in "${throughputs[@]}"; do
                bin/ycsb run jdbc -P jdbc-binding/conf/db.properties -P workloads/workload$workload -p recordcount=$recordcount -p operationcount=$operationcount -target $throughput > "results/throughput_runs/${db}_workload${workload}_tr_${throughput}.txt"
            done

        elif [[ $db == "memcached" ]]; then
            for throughput in "${throughputs[@]}"; do
                bin/ycsb run memcached -s -P workloads/workload$workload -p memcached.hosts=localhost -p recordcount=$recordcount -p operationcount=$operationcount -target $throughput > "results/throughput_runs/${db}_workload${workload}_tr_${throughput}.txt"
            done

        elif [[ $db == "redis" ]]; then
            for throughput in "${throughputs[@]}"; do
                bin/ycsb run redis -s -P workloads/workload$workload -p redis.host=localhost -p recordcount=$recordcount -p operationcount=$operationcount -target $throughput > "results/throughput_runs/${db}_workload${workload}_tr_${throughput}.txt"
            done
        fi
    done
done

