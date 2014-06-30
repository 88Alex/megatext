require 'Qt4'
require_relative 'core/ui/mainwindow.rb'

Qt::Application.new(ARGV) do
	mainWindow = MegaText::MainWindow.new
	mainWindow.show
	exec
end
