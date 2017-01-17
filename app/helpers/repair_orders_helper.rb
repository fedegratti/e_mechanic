module RepairOrdersHelper
  def campaign_path campaign
    repair_order_path campaign
  end
  def repair_path repair
    repair_order_path repair
  end
  def service_path service
    repair_order_path service
  end
  def warranty_path warranty
    repair_order_path warranty
  end
end
