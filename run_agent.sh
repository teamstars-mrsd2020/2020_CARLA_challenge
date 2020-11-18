#!/bin/bash
export CARLA_ROOT=/home/stars/Code/carla_0.9.9             # change to where you installed CARLA
export PORT=2000                                                    # change to port that CARLA is running on
export ROUTES=/home/stars/Code/learning_based/leaderboard/data/routes/route_19.xml  # change to desired route
export TEAM_AGENT=image_agent.py                                     # no need to change
export TEAM_CONFIG=model.ckpt
export HAS_DISPLAY=1
#export TEAM_CONFIG=sample_data                                      # change path to save data

export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.8-py3.5-linux-x86_64.egg           # 0.9.8
export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.9-py3.7-linux-x86_64.egg           # 0.9.8
export PYTHONPATH=$PYTHONPATH:leaderboard
export PYTHONPATH=$PYTHONPATH:leaderboard/team_code
export PYTHONPATH=$PYTHONPATH:scenario_runner

if [ -d "$TEAM_CONFIG" ]; then
    CHECKPOINT_ENDPOINT="$TEAM_CONFIG/$(basename $ROUTES .xml).txt"
else
    CHECKPOINT_ENDPOINT="$(dirname $TEAM_CONFIG)/$(basename $ROUTES .xml).txt"
fi

python leaderboard/leaderboard/leaderboard_evaluator.py \
--challenge-mode \
--track=dev_track_3 \
--scenarios=leaderboard/data/all_towns_traffic_scenarios_public.json  \
--agent=${TEAM_AGENT} \
--agent-config=${TEAM_CONFIG} \
--routes=${ROUTES} \
--checkpoint=${CHECKPOINT_ENDPOINT} \
--port=${PORT}

echo "Done. See $CHECKPOINT_ENDPOINT for detailed results."
