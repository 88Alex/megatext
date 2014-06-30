module MegaText
	class Event
	end
	class ProgramStartEvent < Event
	end
	class FileOpenEvent < Event
		def initialize(filename)
			@filename = filename
		end
	end
	class FileCloseEvent < Event
		def initialize(filename)
			@filename = filename
		end
	end
	class ProgramCloseEvent < Event
	end
	class EventHandler
		@eventListeners = Hash.new
		def self.addEventType(eventName)
			MegaText.const_set(eventName, Class.new {})
			@eventListeners << {MegaText.const_get(eventName) => []}
		end
		def self.addEventListener(eventClass, proc)
			return if not @eventListeners.has_key? eventClass
			@eventListeners[eventClass] << proc
		end
		def self.signalEvent(event)
			return if not @eventListeners.has_key? event.class
			for proc in @eventListeners[event.class]
				proc.call(event)
			end
		end
	end
end
