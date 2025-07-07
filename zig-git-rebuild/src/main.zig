//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.
const TestSubmodule = @import("test-submodule/math.zig");
const SharedTypes = @import("shared_types_lib");
const String = SharedTypes.String;
const GitCommit = @import("git/commit.zig");
const GitBranch = @import("git/branch.zig");

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    // try stdout.print("Run `zig build test` to run the tests.\n", .{});

    // const subtract_result = test_submodule.subtract(10, 5);
    // try stdout.print("Subtract result: {d}\n", .{subtract_result});

    const git_commit_id = GitBranch.GenerateGitCommitID();
    try stdout.print("Generated Git Commit ID: {s}\n", .{git_commit_id});

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit(); // Ensure we deinitialize the arena to avoid memory leaks

    const arena_allocator = arena.allocator();
    const GitCommitType = GitCommit.GitCommitList(String);
    var commit_log = GitCommitType.new(arena_allocator);
    defer commit_log.delete(); // Ensure we deinitialize the list to avoid memory leaks

    // Test adding commits to the list
    try commit_log.add("Initial commit");
    try commit_log.add("Added README");
    try commit_log.add("Implemented feature X");

    for (commit_log.list.items, 0..) |value, num_id| {
        try stdout.print("Commit {d}: {s}\n", .{num_id, value});
    }

    try bw.flush(); // Don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // Try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "use other module" {
    try std.testing.expectEqual(@as(i32, 150), lib.add(100, 50));
}

test "fuzz example" {
    const Context = struct {
        fn testOne(context: @This(), input: []const u8) anyerror!void {
            _ = context;
            // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
            try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input));
        }
    };
    try std.testing.fuzz(Context{}, Context.testOne, .{});
}

const std = @import("std");

/// This imports the separate module containing `root.zig`. Take a look in `build.zig` for details.
const lib = @import("zig_git_rebuild_lib");
