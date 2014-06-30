require 'Qt4'
require_relative '../eventhandler.rb'
require_relative '../editor/editorwidget.rb'
module MegaText
	class MainWindow < Qt::MainWindow
		slots 'newFile()', 'newProject()', 'openFile()', 'openProject()'
		def newFile()
			filename = getSaveFileName(self, "New File",
				"~", # TODO replace with project root
				)
			file = Qt::File.new(filename)
			if not file.open(Qt::IODevice::WriteOnly)
				Qt::MessageBox.critical(self, "I/O Error", \
					"Could not create file #{filename}")
			end
			EventHandler.signalEvent(OpenFileRequestedEvent.new(filename))
			EventHandler.signalEvent(OpenFileEvent.new(filename))
		end
		def newProject()
			# TODO
		end
		def initialize(parent = nil)
			super(parent)
			setWindowTitle("MegaText")
			setCentralWidget(EditorWidget.new(self))
			@fileMenu = menuBar().addMenu("File")
			@newAction = @fileMenu.addAction("New File")
			@newProjAction = @fileMenu.addAction("New Project")
			@openAction = @fileMenu.addAction("Open File")
			@openProjAction = @fileMenu.addAction("Open Project")
		end
	end
end
