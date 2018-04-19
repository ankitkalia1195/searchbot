module Api
  module V1
    class SearchTaskSerializer < ApplicationSerializer
      attributes :created_at, :name, :state

      has_many :search_reports
      has_many :search_results

      def search_reports
        if @instance_options[:load_associations].present?
          if @instance_options[:search_report_ids].present?
            object.search_reports.where(id: @instance_options[:search_report_ids])
          else
            object.search_reports
          end
        else
          []
        end
      end

      def search_results
        if @instance_options[:load_associations].present?
          if @instance_options[:search_result_ids].present?
            object.search_results.where(id: @instance_options[:search_result_ids])
          else
            object.search_results
          end
        else
          []
        end
      end

      def created_at
        object.created_at.to_s(:long)
      end

    end
  end
end
