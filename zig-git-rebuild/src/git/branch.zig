const std = @import("std");
const SharedTypes = @import("shared_types_lib");
const String = SharedTypes.String;
const GitCommit = SharedTypes.GitCommit;

pub fn GenerateGitCommitID() String {
    return "<commit_id>";
}

pub fn CreateGitBranch(branch: String, contributor: String) GitCommit {
    const res = GenerateGitCommitID()[0..2];
    std.log.debug("%s\n", .{res});
    
    const newCommit = GitCommit{
        .contributor = contributor,
        .branch = branch,
        .commit_id = GenerateGitCommitID()
    };
    return newCommit;
}

pub fn GetGitBranchName(commit: *GitCommit) String {
    return commit.branch;
}
