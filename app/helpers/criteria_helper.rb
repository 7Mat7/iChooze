module CriteriaHelper
  def translate_platform(providers)
    platform_translated = []

    if providers.include?("nfx")
      platform_translated << "netflix"
    end

    if providers.include?("dnp")
      platform_translated << "disneyplus"
    end

    if providers.include?("itu")
      platform_translated << "itunes"
    end

    if providers.include?("ocs")
      platform_translated << "go.ocs"
    end

    if providers.include?("prv")
      platform_translated << "primevideo"
    end

    if providers.include?("cpd")
      platform_translated << "canalplus"
    end

    return platform_translated
  end
end
