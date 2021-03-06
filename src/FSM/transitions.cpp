#include "transitions.h"

/*
	First element in array is the source state. The second
	element is the state function return code, the third
	element contains the next state.
*/ 
struct transition state_transitions[] = {
	{	IDLE,			REPEAT,			IDLE		},
	{	IDLE,			NEXT,			ARMED		},
	{	ARMED,			REPEAT,			ARMED		},
	{	ARMED,			NEXT,			BURNOUT		},
	//{	LIFTOFF,		REPEAT,			LIFTOFF		},
	//{	LIFTOFF,		NEXT,			BURNOUT		},
	{	BURNOUT,		REPEAT,			BURNOUT		},
	{	BURNOUT,		NEXT,			AIRBRAKES	},
	{	AIRBRAKES,		REPEAT,			AIRBRAKES	},
	{	AIRBRAKES,		NEXT,			APOGEE		},
	{	APOGEE,			REPEAT,			APOGEE		},
	{	APOGEE,			NEXT,			DROGUE		},
	{	DROGUE,			REPEAT,			DROGUE		},
	{	DROGUE,			NEXT,			CHUTE		},
	{	CHUTE,			REPEAT,			CHUTE		},
	{	CHUTE,			NEXT,			LANDED		},
	{	LANDED,			REPEAT,			LANDED		}
};

state lookup_transition(state current_state, return_code rc) {
	state next_state = current_state;

	for (auto transition : state_transitions) {
		if ((transition.source_state == current_state) && (transition.ret_code == rc)) {
			next_state = transition.destination_state;
			break;
		}
	}
	return next_state;
}