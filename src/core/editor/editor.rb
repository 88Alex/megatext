require 'Qt4'

module MegaText
	class Editor < Qt::TextEdit
		def initialize(filename, parent = 0)
			super(parent)
            file = Qt::File.new(filename)
            file.open(Qt::IODevice.ReadOnly)
            setText(file.readAll)
		end
	end
end
