require 'Qt4'
require_relative '../eventhandler.rb'

module MegaText
	class EditorWidget < Qt::TabWidget
		def initialize(parent = nil)
			super(parent)
            setTabsCloseable true
            @projroot = ""
            fileOpenRequestProc = Proc.new do |event|
                # TODO
            end
            EventHandler.addEventListener(FileOpenRequestedEvent, fileOpenRequestProc)
            fileCloseRequestProc = Proc.new do |event|
                # TODO
            end
            EventHandler.addEventListener(FileCloseRequestedEvent, fileCloseRequestProc)
            projOpenRequestProc = Proc.new do |event|
                @projroot = event.projroot
            end
            EventHandler.addEventListener(ProjectOpenRequestedEvent, projOpenRequestProc)
		end
        attr_reader :projroot
	end
end
