const std = @import("std");
const SharedTypes = @import("shared_types_lib");
const String = SharedTypes.String;

// pub fn CreateGitCommitList(allocator: std.mem.Allocator) !std.ArrayList(String) {
//     const commit_list = std.ArrayList(String).init(allocator);
//     return commit_list;
// }

/// Creates a wrapper Zig ArrayList Data Structure to hold Git commits for demonstration.
///
/// NOTE: The CALLER is responsible for deinitializing the list.
pub fn GitCommitList(comptime T: type) type {    
    return struct {
        const Self = @This();
        list: std.ArrayList(T),

        pub fn new(allocator: std.mem.Allocator) Self {
            return Self{
                .list = std.ArrayList(T).init(allocator),
            };
        }

        pub fn delete(self: *Self) void {
           self.list.deinit();
        }

        pub fn add(self: *Self, value: T) !void {
            try self.list.append(value);
        }
    };
}
