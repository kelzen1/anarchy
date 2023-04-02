events.aim_ack:set(function(e)
    if not menu_script.ragebot_script.ragebot_logs:get(2) then return end 
    local health = e.target['m_iHealth']
    local bodyyaw = e.target['m_flPoseParameter'][11] * 120 - 60
	
    if e.state == nil then
        local hgroup = assistent.hitgroups[e.hitgroup]
        local damage_hit = string.format('%.0f', e.damage)

        if damage_shot == damage_hit then
            dmg_info = '| '
        else
            dmg_info = '| damage: ' .. damage_shot .. ' | ' 
        end

        if aimed_hgroup == hgroup then
            aimed_info = '| '
        else
            aimed_info = '| aimed: ' .. aimed_hgroup .. ' | '
        end

        assistent.hit_log(e.target:get_name(), hgroup, aimed_hgroup, string.format('%.0f', e.damage), damage_shot, health, e.hitchance, e.backtrack or 0)

        if menu_script.ragebot_script.ragebot_logs:get(1) then
			local icon = assistent.visual_icon.person
			local string1 = string.format('%sHit %s in the %s for %s damage (%s health remaining)', icon, string.lower(e.target:get_name()), hgroup, e.damage, health)
            --local string1 = string.format('Hit %s in the %s for %s damage (%s health remaining)', string.lower(e.target:get_name()), hgroup, e.damage, health)

            local hit_color = color(0.58 * 255, 0.78 * 255, 0.23 * 255, 255)
            local string = {
                { "Hit ", color(255, 255, 255, 255) },
                { string.lower(e.target:get_name()) .. " ", hit_color },
                { "in the ", color(255, 255, 255, 255) },
                { hgroup .." ", hit_color },
                { "for ", color(255, 255, 255, 255) },
                { e.damage .. " ", hit_color },
                { "damage ", color(255, 255, 255, 255) },
                { "(", color(255, 255, 255, 255) },
                { health .. " ", hit_color },
                { "health remaining)", color(255, 255, 255, 255) }
            }

            table.insert(assistent.logs, { icon, text = string, text_size = string1, color = hit_color }) 

        end
    else
        assistent.debug_log(string.format('ent [%s] | hitbox [%s] | reason [%s]', e.target:get_name(), aimed_hgroup, e.state))
            
            if menu_script.ragebot_script.ragebot_logs:get(2) then
            
                local nvmthis = { e.hitchance, '% hitchance' }
                local miss = color(255, 50, 50, 255)
				local icon = assistent.visual_icon.person
				local string1 = string.format('%s Missed %s\'s %s due to %s (%s%s)', icon, string.lower(e.target:get_name()), aimed_hgroup, assistent.reasons_misses[e.state], nvmthis[1], nvmthis[2])
                local string = {
                    { "Missed ", color(255, 255, 255, 255) },
                    { string.lower(e.target:get_name()), miss },
                    { "'s ", color(255, 255, 255, 255) },
                    { aimed_hgroup.." ", miss },
                    { "due to ", color(255, 255, 255, 255) },
                    { assistent.reasons_misses[e.state] .." ", miss },
                    { "(", color(255, 255, 255, 255) },
                    { e.hitchance, miss },
                    { "% hitchance)", color(255, 255, 255, 255) }
                }
                
                table.insert(assistent.logs, { text = string, text_size = string1, color = miss }) 
            end

            assistent.missing_log(e.target:get_name(), aimed_hgroup, assistent.reasons_misses[e.state], string.format('%.1f', bodyyaw), aim_hitchance, damage_shot, e.backtrack or 0) -- (entity, hitbox, reason, damage, hitchance, history)
        --end

    end
end)
