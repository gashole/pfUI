pfUI:RegisterModule("cooldown", function ()
  function CooldownFrame_SetTimer(this, start, duration, enable)
    -- disable animation
    this:SetPosition(1,1,1);

    if ( start > 0 and duration > 0 and enable > 0) then
      this.start = start;
      this.duration = duration;
      this.stopping = 0;
      this:SetSequence(0);

      if not this.cd then
        this.cd = CreateFrame("Frame")
        this.cd:SetAllPoints(this)

        this.cd.back = this.cd:CreateTexture(nil,"BACKGROUND")
        this.cd.back:SetTexture(0,0,0,1)
        this.cd.back:SetAlpha(.5)
        this.cd.back:SetParent(this)
        this.cd.back:SetAllPoints(this)

        this.cd.text = this.cd:CreateFontString("Status", "HIGH", "GameFontNormal")
        this.cd.text:SetFont("Interface\\AddOns\\pfUI\\fonts\\homespun.ttf", pfUI_config.global.font_size, "OUTLINE")
        this.cd.text:ClearAllPoints()
        this.cd.text:SetParent(this)
        this.cd.text:SetAllPoints(this)
        this.cd.text:SetJustifyH("CENTER")
        this.cd.text:SetFontObject(GameFontWhite)
      end
      this:Show();
    else
      this:Hide()
      if this.cd then this.cd:Hide() end
    end
  end

  function CooldownFrame_OnUpdateModel()
    if this.start and this.duration then
      local remaining = this.duration - (GetTime() - this.start)

      -- disable GCD notify
      if (remaining >= 0 and this.duration > 2) then
        this.cd:Show()
        local unit = ""
        if remaining > 99 then
          remaining = remaining / 60
          unit = "m"
        end

        if remaining > 99 then
          remaining = remaining / 60
          unit = "h"
        end

        this.cd.text:SetText(ceil(remaining)..unit)
      else
        this:Hide();
        this.cd:Hide()
        this.stopping = 1;
      end
    end
  end

  function CooldownFrame_OnAnimFinished()
    if ( this.stopping == 1 ) then
      this:Hide();
      this.cd:Hide()
    end
  end
end)
