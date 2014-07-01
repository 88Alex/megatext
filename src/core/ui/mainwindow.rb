require 'Qt4'
require_relative '../eventhandler.rb'
require_relative '../editor/editorwidget.rb'
module MegaText
	class MainWindow < Qt::MainWindow
		slots 'newFile()', 'newProject()', 'openFile()', 'openProject()'

        def openProjectFile(projfile)
            EventHandler.signalEvent(OpenProjectRequestedEvent.new(filename))
            EventHandler.signalEvent(OpenProjectEvent.new(filename))
        end

		def newFile()
			filename = Qt::FileDialog.getSaveFileName(self, "New File", \
                                                      $projroot)
			file = Qt::File.new(Qt::Dir.toNativeSeparators("#{EditorWidget.projroot}/#{$filename}"))
			if not file.open(Qt::IODevice::WriteOnly)
				Qt::MessageBox.critical(self, "I/O Error", \
                                        "Could not create file #{filename}")
                return
			end
            file.close
			EventHandler.signalEvent(OpenFileRequestedEvent.new(filename))
			EventHandler.signalEvent(OpenFileEvent.new(filename))
		end
        def newProject()
            projname = Qt::FileDialog.getSaveFileName(self,\
                                                      "Create a directory for your project", \
                                                      "~")
            if not Qt::Dir.new.mkdir(projname)
                Qt::MessageBox.critical(self, "I/O Error", \
                                        "Could not create a project directory.")
                return
            end
            projfile = Qt::File.new(Qt::Dir.toNativeSeparators("#{projname}/.megatext"))
            if not projfile.open(Qt::IODevice::WriteOnly)
                Qt::MessageBox.critical(self, "I/O Error", \
                                        "Could not create the project file.")
                return
            end
            projfile.close
		end
        def openFile()
            filename = Qt::FileDialog.getOpenFileName(self, \
                                                      "Open a file", \
                                                      EditorWidget.projroot)
            EventHandler.signalEvent(OpenFileRequestedEvent.new(filename))
            EventHandler.signalEvent(OpenFileEvent.new(filename))

		def createMenus()
            @fileMenu = menuBar().addMenu("File")
            @newAction = @fileMenu.addAction("New File")
            Qt::Object.connect(@newAction, SIGNAL("triggered()"),
                               self, SLOT("newFile()"))
            @newProjAction = @fileMenu.addAction("New Project")
            Qt::Object.connect(@newProjAction, SIGNAL("triggered()"),
                               self, SLOT("newProject()"))
            @openAction = @fileMenu.addAction("Open File")
            Qt::Object.connect(@openAction, SIGNAL("triggered()"),
                               self, SLOT("openFile()"))
            @openProjAction = @fileMenu.addAction("Open Project")
		end

		def initialize(parent = nil)
			super(parent)
			setWindowTitle("MegaText")
			centerWidget = Qt::Widget.new do
				@layout = Qt::GridLayout.new do
					@fsModel = Qt::FileSystemModel.new
					@fsView = Qt::TreeView.new 
					@fsView.setModel(@fsModel)
					addWidget(@fsView, 0, 0, 1, 1)
					@editor = EditorWidget.new
					addWidget(@editor, 1, 0, 4, 1)
				end
				setLayout(@layout)
			end
			self.centralWidget = centerWidget
		end
	end
end
