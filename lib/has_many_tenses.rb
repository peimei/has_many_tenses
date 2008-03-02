# HasManyTenses
module RailsJitsu
  module HasManyTenses #:nodoc:

    def self.included(base)
      base.extend ClassMethods  
    end

    module ClassMethods
      def has_many_tenses
        include RailsJitsu::HasManyTenses::InstanceMethods
      end
    end
    
    # This module contains class methods
    module SingletonMethods
      def future
        @future ||= find(:all, :conditions => ['created_at >= ?', Time.now])
      end

      def recent
        @recent ||= find(:all, :conditions => ['created_at BETWEEN ? and ?', 15.days.ago, Time.now])
      end

      def past
        @past ||= find(:all, :conditions => ['created_at < ?', Time.now])
      end
    end
    
    # This module contains instance methods
    module InstanceMethods
      def future?
        created_at > Time.now
      end

      def recent?
        created_at.between?(15.days.ago, Time.now)
      end

      def past?
        created_at < Time.now
      end
    end
  end
end
