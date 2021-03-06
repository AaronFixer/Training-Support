name 'TRAINING - Helper Functions'
rs_ca_ver 20161221
short_description 'Common set of helper functions used for CAT training.'

package "common/cat_training_helper_functions"

define run_script(@servers, $script_name, $inputs_hash) do
  
  task_label("In run_script")
    
  @script = rs_cm.right_scripts.get(filter: [ join(["name==",$script_name]) ])
  $right_script_href=@script.href
  
  foreach @server in @servers do

    @task = @server.current_instance().run_executable(right_script_href: $right_script_href, inputs: $inputs_hash)
    
    if equals?(@task.summary, "/^failed/")
      raise "Failed to run " + $right_script_href + "."
    end
    
  end
end