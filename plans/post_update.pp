plan patching::post_update (
  TargetSpec $nodes,
  String[1] $script_linux   = '/opt/patching/bin/post_update.sh',
  String[1] $script_windows = 'C:\ProgramData\patching\bin\post_update.ps1',
  Boolean   $noop           = false,
) {
  $targets = run_plan('patching::get_targets', nodes => $nodes)
  $group_vars = $targets[0].vars
  $_script_linux = pick($group_vars['patching_post_update_script_linux'], $script_linux)
  $_script_windows = pick($group_vars['patching_post_update_script_windows'], $script_windows)

  return run_plan('patching::patch_helper',
                  nodes          => $targets,
                  task           => 'patching::post_update',
                  script_linux   => $_script_linux,
                  script_windows => $_script_windows,
                  noop           => $noop)
}