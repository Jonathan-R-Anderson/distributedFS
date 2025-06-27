module distributed_fs.fs.plan9;

import distributed_fs.fs.node;

/// Plan9-like filesystem tree
class Plan9FS {
    DirNode root;
    DirNode users;
    DirNode hardware;

    this() {
        root = new DirNode("/");
        // /dev, /proc placeholders
        root.add(new DirNode("dev"));
        root.add(new DirNode("proc"));
        // /users for per-user directories
        users = new DirNode("users");
        root.add(users);
        // /hardware abstraction directory
        hardware = new DirNode("hardware");
        root.add(hardware);
    }

    /// create user directory with session customizations
    DirNode createUser(string name) {
        auto udir = new DirNode(name);
        udir.add(new DirNode("env"));
        udir.add(new DirNode("sessions"));
        users.add(udir);
        return udir;
    }

    /// add generic hardware subfolder
    void addHardware(string name) {
        hardware.add(new DirNode(name));
    }
}

