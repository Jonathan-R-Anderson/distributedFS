module distributed_fs.server;

import std.stdio;
import distributed_fs.fs;
import distributed_fs.storage.dht;

Plan9FS gFs;

/// Start the filesystem server
void startServer() {
    writeln("starting server");
    initDht(4, 2); // 4 nodes with 2-way redundancy
    gFs = new Plan9FS();
    gFs.addHardware("cpu");
    gFs.addHardware("disk");
    auto user = gFs.createUser("user0");
    auto f = new FileNode("hello.txt");
    user.add(f);
    writeFile(f, cast(ubyte[])"hello world");
    auto data = readFile(f);
    writeln("read back: ", cast(string)data);
}

