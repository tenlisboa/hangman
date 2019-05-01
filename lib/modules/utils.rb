module Utils
    def load_word
        vector = []
        File.open(File.expand_path('../../../words.txt', __FILE__), 'r') do |file|
            while line = file.gets do
                vector.push(line)
            end
        end

        return vector.sample.chomp
    end
end
