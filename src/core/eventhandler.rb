module MegaText
	class Event
	end
	class ProgramStartEvent < Event
	end
	class FileOpenRequestedEvent < Event
		def initialize(filename)
			@filename = filename
		end
        attr_accessor :filename
	end
	class FileOpenEvent < Event
		def initialize(filename)
			@filename = filename
		end
        attr_accessor :filename
	end
	class FileCloseRequestedEvent < Event
		def initialize(filename)
			@filename = filename
		end
        attr_accessor :filename
	end
	class FileCloseEvent < Event
		def initialize(filename)
			@filename = filename
		end
        attr_accessor :filename
	end
	class ProjectOpenRequestedEvent < Event
		def initialize(projectroot)
			@projectroot = projectroot
		end
        attr_accessor :projectroot
	end
	class ProjectOpenEvent < Event
		def initialize(projectname)
			@projectname = projectroot
		end
        attr_accessor :projectroot
	end
	class ProgramCloseEvent < Event
	end

	class EventHandler
		@eventListeners = Hash.new
		def self.addEventType(eventName)
			MegaText.const_set(eventName, Class.new {})
			@eventListeners.merge! {MegaText.const_get(eventName) => []}
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
