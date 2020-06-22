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
      platform_translated << "amazon"
      platform_translated << "primevideo"
    end

    if providers.include?("cpd")
      platform_translated << "canalplus"
    end

    return platform_translated
  end

  def names_to_acronyms(providers)
    names_to_acronyms = []

    if providers.include?("netflix")
      names_to_acronyms << "nfx"
    end

    if providers.include?("disneyplus")
      names_to_acronyms << "dnp"
    end

    if providers.include?("itunes")
      names_to_acronyms << "itu"
    end

    if providers.include?("go.ocs")
      names_to_acronyms << "ocs"
    end

    if providers.include?("primevideo")
      names_to_acronyms << "prv"
    end

    if providers.include?("canalplus")
      names_to_acronyms << "cpd"
    end

    return names_to_acronyms
  end
end
