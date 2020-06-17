module CriteriaHelper
  def translate_platform(providers)
    platform_translated = []
      if providers.include?("nfx")
        platform_translated << "netflix"
      else platform_translated
      end

      if providers.include?("dnp")
        platform_translated << "disneyplus"
      else platform_translated
      end

      if providers.include?("itu")
        platform_translated << "itunes"
        else platform_translated
      end

      if providers.include?("ocs")
        platform_translated << "go.ocs"
        else platform_translated
      end

      if providers.include?("prv")
        platform_translated << "primevideo"
        else platform_translated
      end

      if providers.include?("cpd")
        platform_translated << "canalplus"
        else platform_translated
      end
      return platform_translated
  end
end
