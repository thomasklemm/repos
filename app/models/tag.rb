class Tag < ActiveRecord::Base
	attr_accessible :context, :name, :repo_count

	def self.update_tags
	
		rocket_tags = RocketTag::Tag.all
		tag_contexts = %w(languages frameworks tags)
		tag_contexts.each do |tag_context|
			rocket_tags.each do |rocket_tag|
				tag = Tag.find_or_initialize_by_name_and_context(rocket_tag.name, tag_context)

				repos = Repo.tagged_with tag.name, on: tag.context

				tag.repo_count = repos.length

				# is tag being used (in this context)?
				if repo_count > 0
					# yes, save tag
					tag.save
				else
					
					# no, not used in this context
					if tag.new_record?
						# it's a record that has only been initialized
						# don't save it
					else
						# tag has been in use before but is no longer
						# destroy tag
						tag.destroy
					end

				end

			end
		end

	end

end
