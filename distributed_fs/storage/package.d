module distributed_fs.storage;

public import distributed_fs.storage.dht;

/// Store an encrypted block via the DHT.
void storeBlockWrapper(string id, const(ubyte)[] data) {
    storeBlock(id, data);
}

/// Retrieve an encrypted block via the DHT.
ubyte[] getBlockWrapper(string id) {
    return getBlock(id);
}
