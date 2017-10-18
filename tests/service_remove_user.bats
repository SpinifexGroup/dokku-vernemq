#!/usr/bin/env bats
load test_helper

setup() {
  dokku "$PLUGIN_COMMAND_PREFIX:create" l >&2
}

teardown() {
  dokku --force "$PLUGIN_COMMAND_PREFIX:destroy" l >&2
}

@test "($PLUGIN_COMMAND_PREFIX:remove-user) Error with no service provided" {
  run dokku "$PLUGIN_COMMAND_PREFIX:remove-user"
  assert_contains "${lines[*]}" "specify a service"
}

@test "($PLUGIN_COMMAND_PREFIX:remove-user) Error with no username provided" {
  run dokku "$PLUGIN_COMMAND_PREFIX:remove-user" l
  assert_contains "${lines[*]}" "specify a user"
}

@test "($PLUGIN_COMMAND_PREFIX:remove-user) success" {
  run dokku "$PLUGIN_COMMAND_PREFIX:remove-user" l user
  assert_contains "${lines[*]}" "User user removed"
}
