require "readline"

$isHistLoaded = false
$histfile = "#{ENV['HOME']}/.mal-history"

def sam_readline(prompt)
    if !$isHistLoaded && File.exist?($histfile)
        $isHistLoaded = true
        if File.readable?($histfile)
            File.readlines($histfile).each {|l| Readline::HISTORY.push(l.chomp)}
        end
    end

    if line = Readline.readline(prompt, true)
        if File.writable?($histfile)
            File.open($histfile, 'a+') {|f| f.write(line+"\n")}
        end
        return line
    else
        return nil
    end
end