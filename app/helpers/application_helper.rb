module ApplicationHelper
  def bootstrap_class_for(flash_type)
    bootstrap = { success: 'success',
                  error: 'danger',
                  alert: 'danger',
                  notice: 'info'
    }
    if bootstrap[flash_type.to_sym]
      "alert-#{bootstrap[flash_type.to_sym]} #{flash_type}"
    else
      "alert-info #{flash_type}"
    end
  end
end
