class SEO

  def self.objects_for_seo(controller_name)
    case controller_name
    when '' # These lines are in for syntactical
      []    # reasons and can be deleted

    # In this area write cases for each of the modules with show pages
    # that you would like to appear in the admin seo section. Eg.
    #
    # when 'articles'
    #   Article.order(:title)

    else
      []
    end
  end

  def self.objects_for_sitemap(controller_name)
    case controller_name
    when '' # These lines are in for syntactical
      []    # reasons and can be deleted

    # In this area write cases for each of the modules with show pages
    # that you would like to appear in the admin sitemap. Eg.
    #
    # when 'articles'
    #   Article.where(:display => true).order(:title)

    else
      []
    end
  end

  def self.rebuild!
    nominal_urls_added = []

    # The method for retrieving the routes and their details keeps changing
    # between rails versions so this is likely to keep needing updating.
    routes = Rails.application.routes.routes.select{|x| [//, /^GET$/].include?(x.verb)}.map do |route|
      { :alias => route.name,
        :path => route.path.spec.to_s.gsub("(.:format)", ""),
        :controller => route.defaults[:controller],
        :action => route.defaults[:action] }
    end

    # Reject routes without a controller such as 301s
    routes = routes.reject{|route| route[:controller].nil?}

    # Reject admin routes
    routes = routes.reject{|route| route[:controller].include?("admin")}

    routes.each do |route|
      if route[:path].include? ":id"
        uses_friendly_id = nil
        has_name_method = nil

        objects_for_sitemap = SEO.objects_for_sitemap(route[:controller])

        SEO.objects_for_seo(route[:controller]).each do |object|
          if uses_friendly_id.nil?
            begin
              object.friendly_id
            rescue NoMethodError
              uses_friendly_id = false
            else
              uses_friendly_id = true
            end
          end

          if has_name_method.nil?
            begin
              object.name
            rescue NoMethodError
              has_name_method = false
            else
              has_name_method = true
            end
          end

          if uses_friendly_id
            seo_entry = SeoEntry.find_or_create_by_nominal_url(route[:path].gsub(':id', object.friendly_id))
            nominal_urls_added << route[:path].gsub(':id', object.friendly_id)

            if seo_entry.title.blank?
              if has_name_method
                seo_entry.title = object.name
              else
                seo_entry.title = object.friendly_id.gsub('-', ' ').capitalize
              end
            end
          else
            seo_entry = SeoEntry.find_or_create_by_nominal_url(route[:path].gsub(':id', object.id.to_s))
            nominal_urls_added << route[:path].gsub(':id', object.id.to_s)

            if seo_entry.title.blank?
              if has_name_method
                seo_entry.title = object.name
              else
                seo_entry.title = "#{object.class.name} - #{object.id}"
              end
            end
          end
          seo_entry.in_sitemap = objects_for_sitemap.include? object
          seo_entry.save
        end
      else
        seo_entry = SeoEntry.find_or_create_by_nominal_url(route[:path])
        nominal_urls_added << route[:path]
        seo_entry.title = route[:alias].gsub('_', ' ').capitalize if seo_entry.title.blank?
        seo_entry.save
      end
    end

    SeoEntry.where("nominal_url NOT IN (?)", nominal_urls_added).each{|x| x.destroy}
  end

end
