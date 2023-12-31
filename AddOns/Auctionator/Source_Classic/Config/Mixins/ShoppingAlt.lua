AuctionatorConfigShoppingAltFrameMixin = CreateFromMixins(AuctionatorConfigShoppingFrameMixin)

function AuctionatorConfigShoppingAltFrameMixin:ShowSettings()
  AuctionatorConfigShoppingFrameMixin.ShowSettings(self)

  self.AlwaysLoadMore:SetChecked(Auctionator.Config.Get(Auctionator.Config.Options.SHOPPING_ALWAYS_LOAD_MORE))
end

function AuctionatorConfigShoppingAltFrameMixin:Save()
  AuctionatorConfigShoppingFrameMixin.Save(self)

  Auctionator.Config.Set(Auctionator.Config.Options.SHOPPING_ALWAYS_LOAD_MORE, self.AlwaysLoadMore:GetChecked())
end
