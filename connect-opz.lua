-- Toggle OP-Z as audio
-- device.
--
-- K2 to toggle OP-Z.
-- K3 to update status.

opz_connected = nil
opz_setup = nil

function init()
  opz_connected = opz_is_connected()
  opz_setup = opz_audio_is_setup()
  redraw()
end

function redraw()
  screen.clear()

  if opz_connected and opz_setup then draw_dancing_music() end
  draw_status_graphics()
  draw_status_text()

  screen.stroke()
  screen.update()
end

function key(n, z)
  opz_connected = opz_is_connected()
  opz_setup = opz_audio_is_setup()
  
  if n == 2 and z == 1 then
    print("Toggling")
    toggle_audio_setup()
  else
    print("Updating")
  end
  redraw()
end

function opz_is_connected()
  opz_connected = os.execute('lsusb -d 2367:000c') or false
  return opz_connected
end

function opz_audio_is_setup()
   opz_setup = os.execute('pidof alsa_in') or false
   return opz_setup
end

function toggle_audio_setup()
  if opz_is_connected() then
    if not opz_audio_is_setup() then
      print("Setting up audio")
      os.execute(_path.this.lib..'connect-opz.sh')
    else
      print("Tearing down audio setup")
      os.execute(_path.this.lib..'disconnect-opz.sh')
    end
  else
    print("It's not connected")
    opz_connected = false
    -- just to maintain sane state.
    os.execute(_path.this.lib..'connect-opz.sh')
  end
  opz_setup = opz_audio_is_setup()
end

function draw_dancing_music()
  for i=0,2 do
    screen.move(math.random(0, 124), math.random(0, 60))
    screen.font_size(math.random(5, 20))
    screen.level(1)
    screen.text("♫")
  end
  screen.stroke()
end

function draw_status_graphics()
  for i=0,3 do
    screen.level(4)
    screen.circle(20 + 15*i, 10, 7)
    screen.stroke()
    
    screen.level(1 + 15*bool_to_number(opz_setup))
    screen.circle(20 + 15*i, 10, 5)
    screen.fill()
    
    screen.level(0)
    screen.circle(20 + 15*i, 10, 2)
    screen.fill()
    
    -- screen.level(5)
    screen.move(16 + 15*i, 7)
    screen.line_rel(9, 7)
    screen.stroke()
  end
end

function draw_status_text()
  screen.level(15)
  screen.move(55, 40)
  screen.font_size(8)
  screen.text_right("connected:")
  screen.text(tostring(opz_connected))
  
  screen.move(55, 47)
  screen.text_right("audio setup:")
  screen.text(tostring(opz_setup))
end

function bool_to_number(value)
  return value == true and 1 or value == false and 0
end
