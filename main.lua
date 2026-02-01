
local _c1 = "DBK_Tx15Pro"
local _f1 = "v1.0"
local _e1 = 10
local _s2 = { "Vbat", "Curr", "Hspd", "Capa", "Bat%", "Tesc", "Tmcu", "1RSS", "2RSS", "RQly", "Thr", "Vbec", "ARM", "Gov", "Vcel","Tmcu","PID#" }
local _d1 = #_s2
local _b1 = 22
local _a1 = 115
local _x8 = {}
local _w3 = {}
local _n1 = { current = 1, name = "Bank 1" }
local _g8
local _a3
local _l2 = ""
local _m2 = ""
local _c5 = 0
local _e5 = { last_start_color = 0, last_end_color = 0 }
local _m5 = 0
local _u4 = false
local _i2 = false
local _l7 = false
local _d5 = false
local _z7 = false
local _u2 = 0  
local _m7 = {
    model_name = "",
    flight_time = "00:00",
    max_power = 0,
    max_current = 0
}
local _a4 = ""
local _c4 = ""
local _b4
local _l5 = ""
local _h5 = {}
local _g4 = 0
local _k7 = 0
local _w6 = { 0, 0, 0 }
local _q8 = 0
local _w4 = 0
local _n5 = { 0, 0 }
local _y6 = { 0, 0 }
local _e6 = { 0, 0 }
local _d9 = false
local _j1 = false
local _x6 = 0
local _b3 = false
local _d3 = 0
local _x5 = {
    { "SquareColor", COLOR, WHITE },
    { "BackgroundColor", COLOR, BLACK },
    { "ValueColor", COLOR, GREEN },
    { "DispLED", BOOL, 0 },
    { "HoldSwitch", SWITCH, 0 }
}
local _i6 = 0
local _j6, _b9 = getVersion()
if _b9 and string.find(_b9, "tx15") then
    _i6 = 30
elseif _b9 and string.find(_b9, "tx16s") then
    _i6 = 0
else
    _i6 = 0
end
 
local function create(zone, _x5)
    local _c9 = {
        zone = zone,
        options = _x5
    }
    for i = 1, _d1 do
        _x8[i] = { 0, 0, 0 }
        _w3[i] = { 0, false }
    end
    _k7 = 1
    _b3 = false
    _d3 = 0
    
    _l2 = ""
    for k, v in pairs(_s2) do
        local _x3 = getFieldInfo(v)
        if _x3 ~= nil then
            _w3[k][1] = _x3.id
            _w3[k][2] = true
        else
            _w3[k][1] = 0
            _w3[k][2] = false
        end
    end
    for i = 1, #_w6 do
        _w6[i] = 0
    end
    _q8 = 0
    _d9 = false
    _j1 = false
    _l7 = false
    _d5 = false
    _z7 = false
    
    _a4 = "[DBK_Tx15Pro]" ..
        string.format("%d", getDateTime().year) ..
        string.format("%02d", getDateTime().mon) ..
        string.format("%02d", getDateTime().day) .. ".log"
    _c4 = "/WIDGETS/DBK_Tx15Pro/logs/" .. _a4
    local _z3 = fstat(_c4)
    local _l6 = 1
    if _z3 ~= nil then
        if _z3.size > 0 then
            _b4 = io.open(_c4, "r")
            _l5 = io.read(_b4, _b1 + 1)
            while true do
                _h5[_l6] = io.read(_b4, _a1 + 1)
                if #_h5[_l6] == 0 then
                    break
                else
                    _l6 = _l6 + 1
                end
            end
            io.close(_b4)
            _w4 = string.sub(_l5, 12, 13)
            _n5[2] = string.sub(_l5, 15, 16)
            _y6[2] = string.sub(_l5, 18, 19)
            _q8 = tonumber(string.sub(_l5, 12, 13)) * 3600
            _q8 = _q8 + tonumber(string.sub(_l5, 15, 16)) * 60
            _q8 = _q8 + tonumber(string.sub(_l5, 18, 19))
        end
    else
        
        _l5 =
            string.format("%d", getDateTime().year) .. '/' ..
            string.format("%02d", getDateTime().mon) .. '/' ..
            string.format("%02d", getDateTime().day) .. '|' ..
            "00:00:00" .. '|' ..
            "00\n"
    end
    local _u7 = string.sub(_l5, 21, 23)
    if tonumber(_u7) ~= nil then
        _g4 = tonumber(_u7)
    end
    if _g4 == 0 then
        _g4 = 1
        _k7 = 1
        _h5[1] = "01|12:34:56|05:30|1850|025|2400|125.5|03500|25.2|22.8|+055|+025|+040|+020|-032|-072|-028|-065|100|095|080|12.6|11.8\n"
    end
    
    _a3 = Bitmap.open("/WIDGETS/DBK_Tx15Pro/default.png")
    return _c9
end
local function update(_c9, _x5)
    _c9.options = _x5
end
local function background(_c9)
end
local function _l4(_c9)
    if _c9.options.BankSwitch ~= 0 then
        local _p1 = getValue(_c9.options.BankSwitch) or 0
        local _o1 = 1
        if _p1 < -300 then
            _o1 = 1
        elseif _p1 > 300 then
            _o1 = 3
        else
            _o1 = 2
        end
        _n1.current = _o1
        return
    end
    local _h4 = getValue("FM")
    if _h4 ~= nil then
        local _o1 = math.floor(_h4) + 1
        _n1.current = math.max(1, math.min(6, _o1))
        return
    end
    _n1.current = 1
end
local function _j3(xs, ys, w, h, r, _q2)
    lcd.drawArc(xs + r, ys + r, r, 270, 360, _q2)
    lcd.drawArc(xs + r, ys + h - r, r, 180, 270, _q2)
    lcd.drawArc(xs + w - r, ys + r, r, 0, 90, _q2)
    lcd.drawArc(xs + w - r, ys + h - r, r, 90, 180, _q2)
    lcd.drawLine(xs + r, ys, xs + w - r, ys, SOLID, _q2)
    lcd.drawLine(xs + r, ys + h, xs + w - r, ys + h, SOLID, _q2)
    lcd.drawLine(xs, ys + r, xs, ys + h - r, SOLID, _q2)
    lcd.drawLine(xs + w, ys + r, xs + w, ys + h - r, SOLID, _q2)
end
local function _h3(center_x, center_y, radius, _g6, max_power, gauge_color, needle_color)
    
    local _c3 = max_power or 5000  
    _g6 = math.max(0, math.min(_c3, _g6))
    
    local _o7 = 225  
    local _l3 = 135    
    local _r8 = 270  
    
    
    lcd.drawArc(center_x, center_y, radius, _o7, 360, gauge_color)
    lcd.drawArc(center_x, center_y, radius - 2, _o7, 360, gauge_color)
    
    lcd.drawArc(center_x, center_y, radius, 0, _l3, gauge_color)
    lcd.drawArc(center_x, center_y, radius - 2, 0, _l3, gauge_color)
    
    local _w5 = 11  
    for i = 0, _w5 - 1 do
        
        local _h1 = _o7 - (i * 27)
        local _i1 = math.rad(_h1)
        
        local _k8 = radius - 5
        local _j8 = radius - 12
        local _e9 = center_x + _k8 * math.cos(_i1)
        local _g9 = center_y - _k8 * math.sin(_i1)
        local _f9 = center_x + _j8 * math.cos(_i1)
        local _h9 = center_y - _j8 * math.sin(_i1)
        lcd.drawLine(_e9, _g9, _f9, _h9, SOLID, gauge_color)
        
        if i % 2 == 0 then
            local _v8 = (_c3 / 10) * i
            local _b5 = ""
            if _v8 >= 1000 then
                _b5 = string.format("%.0fk", _v8 / 1000)
            else
                _b5 = string.format("%.0f", _v8)
            end
            local _d8 = radius - 22
            local _e8 = center_x + _d8 * math.cos(_i1)
            local _f8 = center_y - _d8 * math.sin(_i1)
            lcd.drawText(_e8, _f8, _b5, SMLSIZE + gauge_color + CENTER + VCENTER)
        end
    end
    
    local _z5 = _g6 / _c3
    local _p5 = _o7 - (_z5 * _r8)
    local _q5 = math.rad(_p5)
    
    local _r5 = radius - 15
    local _s5 = center_x + _r5 * math.cos(_q5)
    local _t5 = center_y - _r5 * math.sin(_q5)
    
    lcd.drawLine(center_x, center_y, _s5, _t5, SOLID, needle_color)
    lcd.drawLine(center_x + 1, center_y, _s5 + 1, _t5, SOLID, needle_color)
    lcd.drawLine(center_x, center_y + 1, _s5, _t5 + 1, SOLID, needle_color)
    
    lcd.drawFilledRectangle(center_x - 2, center_y - 2, 5, 5, needle_color)
    
    local _f6 = ""
    
        _f6 = string.format("%.0f°C", _g6)
    
      
    
    lcd.drawText(center_x, center_y + 35, _f6,  needle_color + CENTER + VCENTER)
end
local function _k3(center_x, center_y, radius, _x2, gauge_color, needle_color, inner_value)
    
    local _c3 = 300
    _x2 = math.max(0, math.min(_c3, _x2))
    inner_value = inner_value or 0
    inner_value = math.max(0, math.min(_c3, inner_value))
    
    local _o7 = 225  
    local _l3 = 135    
    local _r8 = 270  
    
    
    lcd.drawArc(center_x, center_y, radius, _o7, 360, gauge_color)
    lcd.drawArc(center_x, center_y, radius - 2, _o7, 360, gauge_color)
    
    lcd.drawArc(center_x, center_y, radius, 0, _l3, gauge_color)
    lcd.drawArc(center_x, center_y, radius - 2, 0, _l3, gauge_color)
    
    if inner_value > 0 then
        local _y4 = inner_value / _c3
        local _z4 = _y4 * _r8
        
        for r = radius - 2, radius do
            
            local _g7 = 100  
            for seg = 0, _g7 - 1 do
                local _b7 = seg / _g7
                
                local _a7 = _o7 + (_b7 * _z4)
                local _z6 = _o7 + ((seg + 1) / _g7 * _z4)
                
                local _r2 = _b7 * _y4
                local _q2
                
                local _h6, _j4, _l1
                if _r2 < 0.33 then
                    
                    local _w7 = _r2 / 0.33
                    _h6 = math.floor(_w7 * 255)
                    _j4 = 255
                    _l1 = 0
                    _q2 = lcd.RGB(_h6, _j4, _l1)
                elseif _r2 < 0.67 then
                    
                    local _w7 = (_r2 - 0.33) / 0.34
                    _h6 = 255
                    _j4 = math.floor(255 - _w7 * 127)
                    _l1 = 0
                    _q2 = lcd.RGB(_h6, _j4, _l1)
                else
                    
                    local _w7 = (_r2 - 0.67) / 0.33
                    _h6 = 255
                    _j4 = math.floor(128 - _w7 * 128)
                    _l1 = 0
                    _q2 = lcd.RGB(_h6, _j4, _l1)
                end
                
                if _a7 >= 360 then
                    lcd.drawArc(center_x, center_y, r, _a7 - 360, _z6 - 360, _q2)
                elseif _z6 > 360 then
                    lcd.drawArc(center_x, center_y, r, _a7, 360, _q2)
                    lcd.drawArc(center_x, center_y, r, 0, _z6 - 360, _q2)
                else
                    lcd.drawArc(center_x, center_y, r, _a7, _z6, _q2)
                end
            end
        end
    end
    
    local _w5 = 11  
    for i = 0, _w5 - 1 do
        
        local _h1 = _o7 - (i * 27)
        local _i1 = math.rad(_h1)
        
        local _k8 = radius - 5
        local _j8 = radius - 12
        local _e9 = center_x + _k8 * math.cos(_i1)
        local _g9 = center_y - _k8 * math.sin(_i1)
        local _f9 = center_x + _j8 * math.cos(_i1)
        local _h9 = center_y - _j8 * math.sin(_i1)
        lcd.drawLine(_e9, _g9, _f9, _h9, SOLID, gauge_color)
        
        if i % 2 == 0 then
            local _v8 = (_c3 / 10) * i
            local _b5 = string.format("%.0f", _v8)
            local _d8 = radius - 22
            local _e8 = center_x + _d8 * math.cos(_i1)
            local _f8 = center_y - _d8 * math.sin(_i1)
            lcd.drawText(_e8, _f8, _b5, SMLSIZE+CENTER + VCENTER + gauge_color)
        end
    end
    
    local _z5 = _x2 / _c3
    local _p5 = _o7 - (_z5 * _r8)
    local _q5 = math.rad(_p5)
    
    local _r5 = radius - 15
    local _s5 = center_x + _r5 * math.cos(_q5)
    local _t5 = center_y - _r5 * math.sin(_q5)
    
    lcd.drawLine(center_x, center_y, _s5, _t5, SOLID, needle_color)
    lcd.drawLine(center_x + 1, center_y, _s5 + 1, _t5, SOLID, needle_color)
    lcd.drawLine(center_x, center_y + 1, _s5, _t5 + 1, SOLID, needle_color)
    
    lcd.drawFilledRectangle(center_x - 2, center_y - 2, 5, 5, needle_color)
    
    local _y8 = string.format("%.0fA", _x2)
    lcd.drawText(center_x , center_y + 34, _y8,  needle_color + CENTER + VCENTER)
end
local function _i4(xs, ys, capa, number, text_color)
    
    local _j7 = 36  
    local _e7 = 10  
    for i = 0, _j7 - 1 do
        local _y5 = (i / _j7) * 100  
        
        local _m6, _q4, _e2
        if _y5 < 50 then
            
            _m6 = 255
            _q4 = math.floor(_y5 * 5.1)  
            _e2 = 0
        else
            
            _m6 = math.floor(255 - (_y5 - 50) * 5.1)  
            _q4 = 255
            _e2 = 0
        end
        local _f7 = lcd.RGB(_m6, _q4, _e2)
        
        local _o7 = 180 + i * _e7
        local _l3 = _o7 + _e7
        
        if _y5 <= number then
            lcd.drawAnnulus(xs, ys, 45, 70, _o7, _l3, _f7)
        end
    end
    lcd.drawText(xs + 2, ys - 10, string.format("%d%%", number), CENTER + VCENTER + DBLSIZE + text_color)
    lcd.drawText(xs, ys + 14, string.format("%dmAh", capa), CENTER + VCENTER + text_color)
end
local function _i8(xs, ys, thr_value, border_color, text_color)
    local _r1 = 105
    local _q1 = 20
    thr_value = math.max(0, math.min(100, thr_value))
    
    lcd.drawRectangle(xs, ys, _r1, _q1, WHITE)
    if thr_value > 0 then
        
        local _j7 = 10
        local _i7 = _r1 / _j7
        for i = 0, _j7 - 1 do
            local _y5 = (i * 10) + 5  
            local _h7 = i * 10  
            
            if _h7 < thr_value then
                
                local _m6, _q4, _e2
                if _y5 < 50 then
                    
                    _m6 = math.floor(_y5 * 5.1)  
                    _q4 = 255
                    _e2 = 0
                else
                    
                    _m6 = 255
                    _q4 = math.floor(255 - (_y5 - 50) * 5.1)  
                    _e2 = 0
                end
                local _f7 = lcd.RGB(_m6, _q4, _e2)
                
                local _d7 = xs + 1 + math.floor(i * _i7)
                local _c7 = math.floor(_i7)
                
                if _h7 + 10 > thr_value then
                    local _n6 = thr_value - _h7
                    _c7 = math.floor(_i7 * (_n6 / 10))
                end
                if _c7 > 0 then
                    lcd.drawFilledRectangle(_d7, ys + 1, _c7, _q1 - 2, _f7)
                end
            end
        end
    end
    
    for i = 1, 9 do
        local _g5 = xs + math.floor((_r1 / 10) * i)
        lcd.drawLine(_g5, ys + 2, _g5, ys + _q1 - 2, SOLID, BLACK)
    end
   
end
local function _r6(xs, ys, _q6, default_color)
    local _a2 = 5
    local _b2 = 7
    _q6 = math.max(0, math.min(100, _q6))
    local _g1 = math.floor((_q6 + 19) / 20)
    for i = 1, 5 do
        local _c2 = xs + (i - 1) * _b2
        local _d2 = ys
        local _z1 = default_color
        if _q6 > 0 and i <= _g1 then
            if i == 1 then
                _z1 = RED
            elseif i == 2 then
                _z1 = ORANGE
            elseif i == 3 then
                _z1 = YELLOW
            elseif i == 4 then
                _z1 = lcd.RGB(173, 255, 47)
            else
                _z1 = GREEN
            end
        end
        lcd.drawFilledRectangle(_c2, _d2, _a2, _a2, _z1)
    end
end
local function _g3(xs, ys, _m8, message, flags)
    local _v3 = {}
    local _v8
    local _x4=4
    local _f5 = 8
    _v3[1] = string.sub(message, _x4, _x4 + _f5 - 1)
    _x4 = 13
    _f5 = 5
    _v3[2] = string.sub(message, _x4, _x4 + _f5 - 1)
    for _w7 = 1, 20 do
        _x4 = _x4 + _f5 + 1
        if _w7 == 2 or _w7 == 16 or _w7 == 17 or _w7 == 18 then
            _f5 = 3
        elseif _w7 == 4 or _w7 == 5 then
            _f5 = 5
        else
            _f5 = 4
        end
        _v8 = tonumber(string.sub(message, _x4, _x4 + _f5 - 1))
        if _w7 == 4 or _w7 == 6 or _w7 == 7 or _w7 == 19 or _w7 == 20 then
            _v3[_w7 + 2] = string.format("%.1f", _v8)
        else
            _v3[_w7 + 2] = string.format("%d", _v8)
        end
    end
    _j3(xs, ys, 400 - 1, 175 - 1, 2, flags)
    lcd.drawLine(xs, ys + 28, xs + 400 - 2, ys + 28, SOLID, flags)
    lcd.drawLine(xs + 200, ys + 28, xs + 200, ys + 175 - 2, SOLID, flags)
    lcd.drawText(xs + 5, ys + 5, _m8, flags)
    lcd.drawText(xs + 5, ys + 30,
        "Time: " .. _v3[2] .. '\n' ..
        "Capa: " .. _v3[3] .. "[mAh]\n" ..
        "Fuel: " .. _v3[4] .. "[%]\n" ..
        "HSpd: " .. _v3[5] .. "[rpm]\n" ..
        "Throttle: " .. _v3[20] .. "[%]\n" ..
        "Current: " .. _v3[6] .. "[A]\n" ..
        "Power: " .. _v3[7] .. "[W]"
        , flags)
    lcd.drawText(xs + 205, ys + 30,
        "Battery: " .. _v3[8] .. " -> " .. _v3[9] .. "[V]\n" ..
        "BEC: " .. _v3[22] .. " -> " .. _v3[21] .. "[V]\n" ..
        "ESC: " .. _v3[11] .. " -> " .. _v3[10] .. "[°C]\n" ..
        "MCU: " .. _v3[13] .. " -> " .. _v3[12] .. "[°C]\n" ..
        _s2[8] .. ": " .. _v3[14] .. " -> " .. _v3[15] .. "[dB]\n" ..
        _s2[9] .. ": " .. _v3[16] .. " -> " .. _v3[17] .. "[dB]\n" ..
        _s2[10] .. ": " .. _v3[18] .. " -> " .. _v3[19] .. "[%]"
        , flags)
end
local function _t6(freq, _f5, pause, flags, freqIncr)
    local _w2 = getTime()
    if _w2 - _c5 > 10 then 
        _c5 = _w2
        playTone(freq, _f5, pause, flags or PLAY_NOW, freqIncr)
    end
end
local function _k4()
    local _j5 = {}
    local _i5 = "/WIDGETS/DBK_Tx15Pro/logs"
    
    local _p8 = string.format("%d%02d%02d", getDateTime().year, getDateTime().mon, getDateTime().day)
    
    local _d4 = nil
    
    if system and system.getFileList then
        
        _d4 = system.getFileList(_i5)
    elseif getFileList then
        
        _d4 = getFileList(_i5)
    end
    if _d4 then
        
        for i = 1, #_d4 do
            local _y3 = _d4[i]
            if _y3 and type(_y3) == "string" then
                
                local _o5, date_str = string.match(_y3, "%[(.+)%](%d%d%d%d%d%d%d%d)%.log")
                if _o5 and _z2 == _p8 then
                    
                    local _c4 = _i5 .. "/" .. _y3
                    local _a8 = io.open(_c4, "r")
                    if _a8 then
                        local _k5 = io.read(_a8, _b1 + 1)
                        io.close(_a8)
                        if _k5 and string.len(_k5) >= 23 then
                            local _e4 = tonumber(string.sub(_k5, 21, 23)) or 0
                            if _e4 > 0 then
                                table.insert(_j5, {
                                    model_name = _o5,
                                    flight_count = _e4,
                                    date = _p8
                                })
                            end
                        end
                    end
                end
            end
        end
    else
        
        
    end
    return _j5
end
local function _e3(xs, ys, _y2, _w8, _n7)
    local _b6 = 450
    local _a6 = 200
    local _c6 = xs - _b6 / 2
    local _d6 = ys - _a6 / 2
    
    lcd.drawFilledRectangle(_c6, _d6, _b6, _a6, BLACK)
    
    _j3(_c6, _d6, _b6, _a6, 10, _w8)
    lcd.drawFilledRectangle(_c6 + 3, _d6 + 3, _b6 - 6, 2, _w8)
    lcd.drawFilledRectangle(_c6 + 3, _d6 + _a6 - 5, _b6 - 6, 2, _w8)
    
    lcd.drawText(_c6 + _b6 / 2, _d6 + 20, "Flight Report", CENTER + VCENTER + DBLSIZE + _w8)
    
    local _n2 = _c6 + 20
    lcd.drawText(_n2, _d6 + 60, "Model:", _n7)
    lcd.drawText(_n2, _d6 + 90, "Flight Time:", _n7)
    lcd.drawText(_n2, _d6 + 120, "Max Power:", _n7)
    lcd.drawText(_n2, _d6 + 150, "Max Current:", _n7)
    
    local _o2 = _c6 + 160
    lcd.drawText(_o2, _d6 + 60, _y2.model_name, BOLD + _n7)
    lcd.drawText(_o2, _d6 + 90, _y2.flight_time, BOLD + _n7)
    local _f6 = string.format("%dW", _y2.max_power)
    if _y2.max_power >= 1000 then
        _f6 = string.format("%.1fkW", _y2.max_power / 1000)
    end
    lcd.drawText(_o2, _d6 + 120, _f6, BOLD + _n7)
    lcd.drawText(_o2, _d6 + 150, string.format("%.1fA", _y2.max_current), BOLD + _n7)
    
    local _p2 = _c6 + 300
    local _k2 = 130
    local _h2 = 30
    local _j2 = 10
    
    local _f2 = _d6 + 55
    _j3(_p2, _f2, _k2, _h2, 5, _w8)
    lcd.drawText(_p2 + _k2 / 2, _f2 + _h2 / 2, "Close", CENTER + VCENTER + _n7)
    
    local _g2 = _f2 + _h2 + _j2
    _j3(_p2, _g2, _k2, _h2, 5, _w8)
    lcd.drawText(_p2 + _k2 / 2, _g2 + _h2 / 2, "Current Log", CENTER + VCENTER + SMLSIZE + _n7)
    
    
    
    
end
local function _i3(x, y, _q2, h_length, v_length)
    
    lcd.drawLine(x, y, x + h_length, y, SOLID, _q2)
    
    lcd.drawLine(x, y, x, y + v_length, SOLID, _q2)
end
local function _f3(x, y, _q2, h_length, v_length)
    
    lcd.drawLine(x, y, x - h_length, y, SOLID, _q2)
    
    lcd.drawLine(x, y, x, y - v_length, SOLID, _q2)
end
local function refresh(_c9, event, touchState)
    local _v6 =  LCD_W or _c9.zone.w
    local _u6 =  LCD_H or _c9.zone.h
    
    if not _l7 then
        if event == nil then
        elseif event ~= 0 then
        if touchState then
            if event == EVT_TOUCH_FIRST then
                _t6(100, 50, 50)
            elseif event == EVT_TOUCH_TAP then
                _t6(200, 50, 50)
            end
        end
        if event == EVT_VIRTUAL_NEXT_PAGE then
            _d3 = (_d3 + 1) % 3
            _b3 = (_d3 == 1)
            _t6(200, 100, 100)
        elseif event == EVT_VIRTUAL_PREV_PAGE then
            if _d3 == 0 then
                _d3 = 2
            elseif _d3 == 1 then
                _d3 = 0
            elseif _d3 == 2 then
                _d3 = 1
                _b3 = false
            end
            _t6(200, 100, 100)
        elseif event == EVT_VIRTUAL_NEXT then
            if _d3 == 1 and not _b3 then
                if _g4 > 0 then
                    if _k7 < _g4 then
                        _k7 = _k7 + 1
                    else
                        _k7 = 1
                    end
                    _t6(200, 50, 100)
                end
            end
        elseif event == EVT_VIRTUAL_PREV then
            if _d3 == 1 and not _b3 then
                if _g4 > 0 then
                    if _k7 > 1 then
                        _k7 = _k7 - 1
                    else
                        _k7 = _g4
                    end
                    _t6(200, 50, 100)
                end
            end
        elseif event == EVT_VIRTUAL_ENTER then
            if _d3 == 1 then
                if _g4 > 0 and _k7 > 0 and _k7 <= _g4 and _h5[_k7] then
                    _b3 = not _b3
                    _t6(100, 200, 100, PLAY_NOW, 10)
                else
                    _t6(3000, 100, 50)
                end
            else
                _t6(600, 50, 50)
            end
        elseif event == EVT_VIRTUAL_EXIT then
            _d3 = 0
            _b3 = false
            _t6(10000, 200, 100, PLAY_NOW, -60)
        end
        end
    else
        
        if event ~= nil and event ~= 0 then
            
            if event == EVT_VIRTUAL_ENTER or event == EVT_VIRTUAL_EXIT then
                _l7 = false
                _t6(200, 100, 100)
            
            elseif event == EVT_TOUCH_TAP and touchState then
                
                local _b6 = 450
                local _a6 = 200
                local _c6 = (_v6 - _b6) / 2
                local _d6 = (_u6 - _a6) / 2
                local _p2 = _c6 + 300
                local _k2 = 130
                local _h2 = 30
                local _j2 = 10
                local _f2 = _d6 + 55
                local _g2 = _f2 + _h2 + _j2
                
                if touchState.x >= _p2 and touchState.x <= _p2 + _k2 and
                   touchState.y >= _f2 and touchState.y <= _f2 + _h2 then
                    _l7 = false
                    _t6(200, 100, 100)
                
                elseif touchState.x >= _p2 and touchState.x <= _p2 + _k2 and
                       touchState.y >= _g2 and touchState.y <= _g2 + _h2 then
                    
                    _l7 = false
                    _d3 = 1
                    _b3 = true
                    
                    if _g4 > 0 then
                        _k7 = _g4
                    end
                    _t6(200, 100, 100)
                
                
                
                
                
                
                
                end
            end
        end
    end
    lcd.setColor(CUSTOM_COLOR, _c9.options.BackgroundColor)
    local _y1 = lcd.getColor(CUSTOM_COLOR)
    lcd.setColor(CUSTOM_COLOR, _c9.options.SquareColor)
    local _n7 = lcd.getColor(CUSTOM_COLOR)
    lcd.setColor(CUSTOM_COLOR, _c9.options.ValueColor)
    local _w8 = lcd.getColor(CUSTOM_COLOR)
    
    if _d3 == 1 and _b3 then
        
        lcd.drawFilledRectangle(0, 0, _v6, _u6, _y1)
        
        if _g4 > 0 and _k7 > 0 and _k7 <= _g4 and _h5[_k7] then
            local _m8 = "Flight #" .. string.format("%02d", _k7) .. "/" .. string.format("%02d", _g4)
            _g3(40, 50, _m8, _h5[_k7], _n7)
        end
        
        lcd.drawText(10, 10, "Press EXIT to return", _n7)
        return  
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    if LED_STRIP_LENGTH and LED_STRIP_LENGTH > 0 then
        if _c9.options.DispLED == 1 then
            
            local _q7 = _c9.options.SquareColor
            local _n3 = _c9.options.ValueColor
            if _e5.last_start_color ~= _q7 or _e5.last_end_color ~= _n3 then
                _e5.last_start_color = _q7
                _e5.last_end_color = _n3
                local _t7 = math.floor(_q7 / 65536)
                local _s7 = math.floor(_t7 / 2048) * 8
                local _r7 = (math.floor(_t7 / 32) % 64) * 4
                local _p7 = (_t7 % 32) * 8
                local _q3 = math.floor(_n3 / 65536)
                local _p3 = math.floor(_q3 / 2048) * 8
                local _o3 = (math.floor(_q3 / 32) % 64) * 4
                local _m3 = (_q3 % 32) * 8
                for i = 0, LED_STRIP_LENGTH - 1 do
                    local _k6 = 0.5
                    local _k6 = (i % 2) / 1
                    local _m6 = _s7 + (_p3 - _s7) * _k6
                    local _q4 = _r7 + (_o3 - _r7) * _k6
                    local _e2 = _p7 + (_m3 - _p7) * _k6
                    setRGBLedColor(i, math.floor(_m6), math.floor(_q4), math.floor(_e2))
                end
                applyRGBLedColors()
            end
        else
            
            if _e5.last_start_color ~= 0 or _e5.last_end_color ~= 0 then
                _e5.last_start_color = 0
                _e5.last_end_color = 0
                for i = 0, LED_STRIP_LENGTH - 1 do
                    setRGBLedColor(i, 0, 0, 0)  
                end
                applyRGBLedColors()
            end
        end
    end
    lcd.drawFilledRectangle(0, 0, _v6, _u6, _y1)
    local _n8 = 25
    
    local _w2 = getDateTime()
    local _l8 = string.format("%02d:%02d:%02d", _w2.hour, _w2.min, _w2.sec)
    lcd.drawText(385, 260+_i6, _l8, BOLD + _n7)
    
    local _t2 = model.getInfo().name
    if _l2 ~= _t2 then
        _l2 = _t2
        _m2 = "/WIDGETS/DBK_Tx15Pro/"..string.sub(_l2, 2)..".png"
        
        if _t2 and _t2 ~= "" then
            
            local _s6 = string.gsub(_t2, "[<>:\"/\\|?*]", "")
            local _u5 = "[".. _s6 .. "]" ..
                string.format("%d", getDateTime().year) ..
                string.format("%02d", getDateTime().mon) ..
                string.format("%02d", getDateTime().day) .. ".log"
            local _v5 = "/WIDGETS/DBK_Tx15Pro/logs/" .. _u5 
            
            if _v5 ~= _c4 then
                _a4 = _u5
                _c4 = _v5
            end
        end
        if fstat(_m2) then
            _g8 = Bitmap.open(_m2)
        else
            _g8 = nil
        end
    end
     
    lcd.drawText(255, 260+_i6, _l2, BOLD + _w8)
    local _u8 = getValue("tx-voltage") or getValue("TxBt") or 0
    local _s8 = string.format("%.1fV", _u8)
    local _t8 = _w8   
    if _u8 < 6.5 then
        _t8 = RED
    elseif _u8 >= 6.5 and _u8 <= 7.0 then
        _t8 = YELLOW
    end
    lcd.drawText(400, 13, "Tx", BOLD + _n7)
    lcd.drawText(420, 13, _s8, BOLD + _t8)
    lcd.drawText(30, _n8 / 2+_e1, "Bank" , CENTER + VCENTER + _n7)
    lcd.drawText(100, _n8 / 2+_e1, "HOLD" , CENTER + VCENTER + _n7)
    lcd.drawText(170, _n8 / 2+_e1, "RSSI" , CENTER + VCENTER + _n7)
    
    _n1.current = (_w3[17][2] and _x8[17][1]) or 1
    local _m1 = _n7
    if _n1.current == 1 then
        _m1 = lcd.RGB(0, 100, 255)      
    elseif _n1.current == 2 then
        _m1 = lcd.RGB(255, 165, 0)      
    elseif _n1.current == 3 then
        _m1 = lcd.RGB(255, 255, 0)      
    end
    lcd.drawText(20, 35+_e1, tostring(_n1.current), CENTER + VCENTER + BOLD + MIDSIZE + _m1)
    local _k1 = (_w3[13][2] and _x8[13][1]) or 0  
    local _p4 = (_w3[14][2] and _x8[14][1]) or 0  
    
    
    
    local _a5 = false
    if _w3[13][2] then
        
        _a5 = (_k1 == 1 or _k1 == 3)
    else
        
        _a5 = arm_switch_active
    end
    local _o4 = { "OFF", "IDLE", "SPOOLUP", "RECOVERY", "ACTIVE", "THR-OFF", "LOST-HS", "AUTOROT", "BAILOUT" }
    if _a5 then
        lcd.drawText(280, 13+_e1, "GOV:", CENTER + VCENTER + _n7) 
        if _w3[14][2] then
            local _n4 = _o4[_p4 + 1] or "UNK"
            if _n4 == "SPOOLUP" then
                lcd.drawText(340, 12+_e1, _n4, CENTER + VCENTER +  _w8)
            else 
                lcd.drawText(320, 12+_e1, _n4, CENTER + VCENTER +  _w8)
            end
        else
            lcd.drawText(340, 12+_e1, "ARMED", CENTER + VCENTER +  GREEN)
        end
    else
        lcd.drawText(280, 13+_e1, "ARM:", CENTER + VCENTER + _n7)
        if _w3[13][2] then
            lcd.drawText(345, 15+_e1, "DISARMED", CENTER + VCENTER +   RED)
        elseif _c9.options.ArmSwitch ~= 0 then
            lcd.drawText(345, 15+_e1, "DISARMED", CENTER + VCENTER +   RED)
        else
            lcd.drawText(345, 15+_e1, "NO TELE", CENTER + VCENTER +   BLINK + RED)
        end
    end
    
    local _s4 = false
    if _c9.options.HoldSwitch ~= 0 then
        local _v7 = getSwitchValue(_c9.options.HoldSwitch)
        if _v7 and _v7 ~= 0 and _v7 ~= false then
            _s4 = true
        else
            _s4 = false
        end
    end
    local _v4 = _s4 and "On" or "Off"
    local _t4 = _s4 and GREEN or RED
    lcd.drawText(97, 35+_e1, _v4, CENTER + VCENTER + MIDSIZE + _t4)
    for k = 1, _d1 do
        if _w3[k][2] then
            local _m4 = getValue(_w3[k][1])
            _x8[k][1] = _m4  
            if not _s4 then
                if _m4 > _x8[k][2] then
                    _x8[k][2] = _m4
                elseif _m4 < _x8[k][3] then
                    _x8[k][3] = _m4
                end
            end
        end
    end
    if _a5 then
        if _j1 == false then
            
            _j1 = true
            
            for s = 1, _d1 do
                if _w3[s][2] then
                    _x8[s][2] = _x8[s][1]  
                    _x8[s][3] = _x8[s][1]  
                end
            end
            _w6[1] = 0  
            _e6[1] = 0  
            _e6[2] = 0
            _d9 = false
        end
    else
        if _j1 then
            
            _j1 = false
            _d9 = true
        end
    end
    _e6[2] = math.min(math.floor(_x8[1][1] * _x8[2][1]), 99999)
    if _e6[1] < _e6[2] then
        _e6[1] = _e6[2]
    end
    _w6[3] = getRtcTime()
    if _w6[2] ~= _w6[3] then
        _w6[2] = _w6[3]
        if _j1 then
            _w6[1] = _w6[1] + 1  
            _q8 = _q8 + 1  
        end
    end
    _n5[1] = string.format("%02d", math.floor(_w6[1] % 3600 / 60))
    _y6[1] = string.format("%02d", _w6[1] % 3600 % 60)
    _w4 = string.format("%02d", math.floor(_q8 / 3600))
    _n5[2] = string.format("%02d", math.floor(_q8 % 3600 / 60))
    _y6[2] = string.format("%02d", _q8 % 3600 % 60)
    
    _m5 = _m5 + 1
    if _d9 and _g4 < 57 and _w6[1] > 30 and _m5 >= 250 then 
        _m5 = 0
        
        local _t2 = model.getInfo().name
        if not _t2 or _t2 == "" then
            
            _d9 = false
            return
        end
        
        local _s6 = string.gsub(_t2, "[<>:\"/\\|?*]", "")
        _d9 = true
        
        if string.find(_s6, "DBK_Tx15Pro") then
            _d9 = false
        end
        if _d9 then
            _a4 = "[".. _s6 .."]" ..
                string.format("%d", getDateTime().year) ..
                string.format("%02d", getDateTime().mon) ..
                string.format("%02d", getDateTime().day) .. ".log"
            _c4 = "/WIDGETS/DBK_Tx15Pro/logs/" .. _a4
            
            local _r3 = fstat(_c4)
            if _r3 and _r3.size > 0 then
                
                local _b8 = io.open(_c4, "r")
                local _t3 = {}
                local _u3 = ""
                local _s3 = 0
                if _b8 then
                    _u3 = io.read(_b8, _b1 + 1)
                    if _u3 and string.len(_u3) >= 23 then
                        local _u7 = string.sub(_u3, 21, 23)
                        if tonumber(_u7) ~= nil then
                            _s3 = tonumber(_u7)
                        end
                    end
                    
                    local _l6 = 1
                    while true do
                        local _y2 = io.read(_b8, _a1 + 1)
                        if #_y2 == 0 then
                            break
                        else
                            _t3[_l6] = _y2
                            _l6 = _l6 + 1
                        end
                    end
                    io.close(_b8)
                end
                
                _g4 = _s3 + 1
                
                _b4 = io.open(_c4, "w")
                if not _b4 then
                    _d9 = false
                    return
                end
                
                _l5 =
                    string.format("%d", getDateTime().year) .. '/' ..
                    string.format("%02d", getDateTime().mon) .. '/' ..
                    string.format("%02d", getDateTime().day) .. '|' ..
                    _w4 .. ':' .. _n5[2] .. ':' .. _y6[2] .. '|' ..
                    string.format("%02d", _g4) .. "\n"
                io.write(_b4, _l5)
                
                for i = 1, _s3 do
                    if _t3[i] then
                        io.write(_b4, _t3[i])
                    end
                end
                
                _h5[_g4] =
                    string.format("%02d", _g4) .. '|' ..
                    string.format("%02d", getDateTime().hour) .. ':' ..
                    string.format("%02d", getDateTime().min) .. ':' ..
                    string.format("%02d", getDateTime().sec) .. '|' ..
                    _n5[1] .. ':' .. _y6[1] .. '|' ..
                    string.format("%04d", math.max(0, _x8[4][1] - _x8[4][3])) .. '|' ..
                    string.format("%03d", math.max(0, _x8[5][2] - _x8[5][1])) .. '|' ..
                    string.format("%04d", _x8[3][2]) .. '|' ..
                    string.format("%05.1f", _x8[2][2]) .. '|' ..
                    string.format("%05d", _e6[1]) .. '|' ..
                    string.format("%04.1f", _x8[1][2]) .. '|' ..
                    string.format("%04.1f", _x8[1][3]) .. '|' ..
                    string.format("%+04d", _x8[6][2]) .. '|' ..
                    string.format("%+04d", _x8[6][3]) .. '|' ..
                    string.format("%+04d", _x8[7][2]) .. '|' ..
                    string.format("%+04d", _x8[7][3]) .. "|" ..
                    string.format("%+04d", _x8[8][2]) .. '|' ..
                    string.format("%+04d", _x8[8][3]) .. '|' ..
                    string.format("%+04d", _x8[9][2]) .. '|' ..
                    string.format("%+04d", _x8[9][3]) .. '|' ..
                    string.format("%03d", _x8[10][2]) .. '|' ..
                    string.format("%03d", _x8[10][3]) .. '|' ..
                    string.format("%03d", _x8[11][2]) .. '|' ..
                    string.format("%04.1f", _x8[12][2]) .. '|' ..
                    string.format("%04.1f", _x8[12][3]) .. "\n"
                io.write(_b4, _h5[_g4])
            else
                
                _g4 = 1
                _b4 = io.open(_c4, "w")
                if not _b4 then
                    _d9 = false
                    return
                end
                _l5 =
                    string.format("%d", getDateTime().year) .. '/' ..
                    string.format("%02d", getDateTime().mon) .. '/' ..
                    string.format("%02d", getDateTime().day) .. '|' ..
                    _w4 .. ':' .. _n5[2] .. ':' .. _y6[2] .. '|' ..
                    string.format("%02d", _g4) .. "\n"
                io.write(_b4, _l5)
                for w = 1, _g4 - 1 do
                    io.write(_b4, _h5[w])
                end
                _h5[_g4] =
                    string.format("%02d", _g4) .. '|' ..
                    string.format("%02d", getDateTime().hour) .. ':' ..
                    string.format("%02d", getDateTime().min) .. ':' ..
                    string.format("%02d", getDateTime().sec) .. '|' ..
                    _n5[1] .. ':' .. _y6[1] .. '|' ..
                    string.format("%04d", math.max(0, _x8[4][1] - _x8[4][3])) .. '|' ..
                    string.format("%03d", math.max(0, _x8[5][2] - _x8[5][1])) .. '|' ..
                    string.format("%04d", _x8[3][2]) .. '|' ..
                    string.format("%05.1f", _x8[2][2]) .. '|' ..
                    string.format("%05d", _e6[1]) .. '|' ..
                    string.format("%04.1f", _x8[1][2]) .. '|' ..
                    string.format("%04.1f", _x8[1][3]) .. '|' ..
                    string.format("%+04d", _x8[6][2]) .. '|' ..
                    string.format("%+04d", _x8[6][3]) .. '|' ..
                    string.format("%+04d", _x8[7][2]) .. '|' ..
                    string.format("%+04d", _x8[7][3]) .. "|" ..
                    string.format("%+04d", _x8[8][2]) .. '|' ..
                    string.format("%+04d", _x8[8][3]) .. '|' ..
                    string.format("%+04d", _x8[9][2]) .. '|' ..
                    string.format("%+04d", _x8[9][3]) .. '|' ..
                    string.format("%03d", _x8[10][2]) .. '|' ..
                    string.format("%03d", _x8[10][3]) .. '|' ..
                    string.format("%03d", _x8[11][2]) .. '|' ..
                    string.format("%04.1f", _x8[12][2]) .. '|' ..
                    string.format("%04.1f", _x8[12][3]) .. "\n"
                io.write(_b4, _h5[_g4])
            end
            io.close(_b4)
            _d9 = false
        end
    end
    local _u1 = (_w3[1][2] and _x8[1][1]) or 0  
    lcd.drawText(179, 63+_e1, "Volt" , CENTER + VCENTER + _n7)
    local _v1 = string.format("%.2fv", _u1)
     if _u1 == 0 then
        lcd.drawText( 195, 82+_e1, _v1, CENTER + VCENTER +MIDSIZE+ _w8)  
     else
        lcd.drawText( 200, 82+_e1, _v1, CENTER + VCENTER +MIDSIZE+ _w8)  
     end
    lcd.drawText(180, 110+_e1, "Vcel" , CENTER + VCENTER + _n7)
    local _z8 = (_w3[15][2] and _x8[15][1]) or 0  
    local _a9 = "0.00v"
    if _z8 > 0 then
        _a9 = string.format("%.2fv", _z8)
    end
    lcd.drawText(195, 129+_e1, _a9, CENTER + VCENTER + MIDSIZE + _w8)
    lcd.drawText(179, 155+_e1, "Bec" , CENTER + VCENTER + _n7)    
    local _w1 = (_w3[12][2] and _x8[12][1]) or 0  
    local _x1 = "0.00v"
    if _w1 > 0 then
        _x1 = string.format(_w1 < 10 and "%.2fv" or "%.1fv", _w1)
    end
    lcd.drawText(195, 175+_e1, _x1, CENTER + VCENTER +MIDSIZE + _w8)
    
    
    local _t1 = (_w3[5][2] and _x8[5][1]) or 0  
    local _s1 = (_w3[4][2] and _x8[4][1]) or 0  
    _i4(80, 140, _s1,_t1, _w8)
    lcd.drawText(280, 158, "Time" , CENTER + VCENTER + _n7)
    local _f4 = string.format("%s:%s", _n5[1], _y6[1])
    lcd.drawText(340, 158, _f4, CENTER + VCENTER +MIDSIZE+ _w8)
    
    
    local _e4 = 0
    local _t2 = model.getInfo().name
    if _t2 and _t2 ~= "" then
        local _s6 = string.gsub(_t2, "[<>:\"/\\|?*]", "")
        local _x7 = "[".. _s6 .."]" ..
            string.format("%d", getDateTime().year) ..
            string.format("%02d", getDateTime().mon) ..
            string.format("%02d", getDateTime().day) .. ".log"
        local _y7 = "/WIDGETS/DBK_Tx15Pro/logs/" .. _x7
        local _z3 = fstat(_y7)
        if _z3 ~= nil and _z3.size > 0 then
            local _b8 = io.open(_y7, "r")
            if _b8 then
                local _c8 = io.read(_b8, _b1 + 1)
                if _c8 and string.len(_c8) >= 23 then
                    local _u7 = string.sub(_c8, 21, 23)
                    if tonumber(_u7) ~= nil then
                        _e4 = tonumber(_u7)
                    end
                end
                io.close(_b8)
            end
        end
    end
    
    lcd.drawText(400, 158, _e4, CENTER + VCENTER +MIDSIZE+ _w8)
    
    
    local _h8 = (_w3[11][2] and _x8[11][1]) or 0  
    _i8(310, 118, _h8, _w8, _w8)
    lcd.drawText(273, 128, "Thr" , CENTER + VCENTER + _n7)
    lcd.drawText(438, 118+_e1, string.format("%d%%", _h8) , CENTER + VCENTER + _n7)
 
    local _p6 = (_w3[3][2] and _x8[3][1]) or 0  
    local _o6 = "0"
    if _p6 > 0 then
        _o6 = string.format("%d", _p6)
    end
    lcd.drawText(335, 65+_e1, _o6, CENTER + VCENTER + DBLSIZE + BOLD + _w8)
    lcd.drawText(430, 78+_e1, "Rpm" , CENTER + VCENTER + _n7)
    lcd.drawFilledRectangle(260, 105, 190, 1, _n7)
     
    local _q6 = (_w3[10][2] and _x8[10][1]) or 0
    _r6(200, 10+_e1, _q6, WHITE)
    if _q6 > 0 then
        lcd.drawText(175, 33+_e1, string.format("%ddB", _q6), CENTER + VCENTER  + _w8)
    else
        lcd.drawText(165, 33+_e1, "---", CENTER + VCENTER + MIDSIZE + RED)
    end
    
    
    local _r4 = false
    if _w3[10][2] then
        
        if _q6 > 0 then
            _r4 = true
        end
    end
    
    if _r4 == true and _z7 == false then
        _z7 = true
        _d5 = true
    end
    
    if _z7 == true then
        if _r4 == false and _d5 == true then
            
            _l7 = true
            _d5 = false
            _m7.model_name = _l2
            _m7.flight_time = string.format("%s:%s", _n5[1], _y6[1])
            _m7.max_power = _e6[1]
            _m7.max_current = _x8[2][2]
            _t6(2000, 300, 100, PLAY_NOW)
        elseif _r4 == true then
            
            _d5 = true
            _l7 = false
        end
    end
    
    if _g8 then
        if _b9 and string.find(_b9, "tx15") then
             lcd.drawBitmap(_g8, 254, 150+_i6)
        else
             lcd.drawBitmap(_g8, 254, 150+_i6)
        end
    else
        if _a3 then
            lcd.drawBitmap(_a3, 254, 150+_i6)
        end
    end
     
    if _b9 and string.find(_b9, "tx15") then
       local _x2 = (_w3[2][2] and _x8[2][1]) or 0
       
       if not _a5 then
           
           _u2 = 0
       else
           
           if _x2 > _u2 then
               _u2 = _x2
           end
       end
       local _v2 = "0.0A"
       if _x2 > 0 then
           _v2 = string.format("%.1fA", _x2)
       end
       
      
       local _g6 = _u1 * _x2
       local _f6 = "0.0W"
       if _g6 > 0 then
           if _g6 >= 1000 then
               _f6 = string.format("%.1fkW", _g6 / 1000)
           else
               _f6 = string.format("%.0fW", _g6)
           end
       end
     
       
       local _o8 = (_w3[7][2] and _x8[7][1]) or 0
       
       _h3(190, 260+_e1, 50, _o8, 100, _n7, _w8)
       
       _k3(65, 260+_e1, 50, _x2, _n7, _w8, _u2)
    end
    
    if _l7 then
        _e3(_v6 / 2, _u6 / 2, _m7, _w8, _n7)
    end
    
   
   
end
return {
    name = _c1,
    options = _x5,
    create = create,
    update = update,
    refresh = refresh,
    background = background
}