function SignalBus() constructor {
    listeners = [];

    on = function(event_name, callback, owner_instance, priority = 0) {
        array_push(listeners, {
            event: event_name,
            callback: callback,
            owner: owner_instance,
            once: false,
            priority: priority
        });
    }

    once = function(event_name, callback, owner_instance, priority = 0) {
        array_push(listeners, {
            event: event_name,
            callback: callback,
            owner: owner_instance,
            once: true,
            priority: priority
        });
    }

    off = function(event_name, callback) {
        for (var i = 0; i < array_length(listeners); i++) {
            var l = listeners[i];
            if (l.event == event_name && l.callback == callback) {
                array_delete(listeners, i, 1);
                break;
            }
        }
    }

    emit = function(event_name, data) {
        // Filter matching listeners (including wildcards)
        var to_call = [];
        for (var i = 0; i < array_length(listeners); i++) {
            var l = listeners[i];
            if (l.event == event_name || l.event == "*") {
                array_push(to_call, l);
            }
        }

        // Sort by priority (descending)
        array_sort(to_call, function(a, b) {
            return b.priority - a.priority;
        });

        // Call listeners
        var i = 0;
        while (i < array_length(to_call)) {
            var l = to_call[i];

            // Auto-cleanup if owner is destroyed
            if (!instance_exists(l.owner)) {
            // Find and remove from original listeners array
	            for (var j = 0; j < array_length(listeners); j++) {
	                if (listeners[j] == l) {
	                    array_delete(listeners, j, 1);
	                    break;
	                }
	            }
	            i++;
           		continue;
       		}


            // Call the callback
            l.callback(data);

            
			// Remove if once-only
       		if (l.once) {
	            for (var j = 0; j < array_length(listeners); j++) {
	                if (listeners[j] == l) {
	                    array_delete(listeners, j, 1);
	                    break;
	                }
	            }
	        }


            i++;
        }
    }
}
