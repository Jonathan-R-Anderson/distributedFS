module distributed_fs.storage.dht;

import std.stdio;
import std.string;

/// Simple in-memory DHT used for examples.
struct Dht {
    // vector of node tables mapping id -> data
    private ubyte[][string][] nodes;
    size_t redundancy;

    this(size_t nodeCount, size_t redundancy) {
        nodes.length = nodeCount;
        foreach(i; 0 .. nodeCount) {
            nodes[i] = ubyte[][string].init;
        }
        this.redundancy = redundancy;
    }

    static size_t hash(string key) {
        size_t h;
        foreach(b; cast(ubyte[])key) {
            h = h * 31 + b;
        }
        return h;
    }

    void store(string id, const(ubyte)[] data) {
        foreach(replica; 0 .. redundancy) {
            auto idx = (hash(id) + replica) % nodes.length;
            nodes[idx][id] = data.dup;
        }
    }

    ubyte[] get(string id) const {
        foreach(table; nodes) {
            auto ptr = id in table;
            if(ptr !is null) {
                return (*ptr).dup;
            }
        }
        return null;
    }
}

__gshared Dht gDht;

/// Initialize global DHT instance
void initDht(size_t nodes, size_t redundancy) {
    gDht = Dht(nodes, redundancy);
}

/// Store a block in the global DHT
void storeBlock(string id, const(ubyte)[] data) {
    gDht.store(id, data);
}

/// Retrieve a block from the global DHT
ubyte[] getBlock(string id) {
    return gDht.get(id);
}
