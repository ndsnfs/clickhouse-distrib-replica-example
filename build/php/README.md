Hosts:
- click_net.root-shard
- click_net.shard2_replica1
- click_net.shard2_replica2

```bash
docker run \
    --network clickhouse-shard-example_click_net \
    -it \
    --rm \
    clickhouse-shard-example_php \
    bash -c 'clickhouse-client -h {host}'
```

