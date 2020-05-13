CREATE DATABASE IF NOT EXISTS example_db

DROP table IF EXISTS example_db.shard_table

-- shard 1
CREATE TABLE IF NOT EXISTS example_db.shard_table
(
  `Ids` UInt32,
  `Times` DateTime,
  `Messages` String,
  `Codes` UInt16
)
ENGINE = MergeTree()
PARTITION BY toYYYYMM(Times)
ORDER BY (Ids)

-- shard 2 replica 1-2
CREATE TABLE IF NOT EXISTS example_db.shard_table
(
  `Ids` UInt32,
  `Times` DateTime,
  `Messages` String,
  `Codes` UInt16
)
ENGINE = ReplicatedMergeTree('/clickhouse/tables/{shard}/example_db__shard_table', '{replica}')
PARTITION BY toYYYYMM(Times)
ORDER BY (Ids)

CREATE TABLE IF NOT EXISTS example_db.d_shard_table AS example_db.shard_table
ENGINE Distributed(my_cluster, example_db, shard_table);

INSERT INTO example_db.shard_table(`Ids`,`Times`,`Messages`,`Codes`) VALUES (1,now(),'Ошибка',400)
