require 'Qt4'
require_relative '../editor/editorwidget.rb'
module MegaText
	class MainWindow < Qt::MainWindow
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
