// Shared Types Used Throughout the Project:

pub const String = []const u8;

pub const GitCommit = struct {
    commit_id: String,
    contributor: String,
    branch: String,
};
