json.extract! icms, :id, :estado, :aliquota_icms, :aliquota_icms_st, :mva_icms_st, :fcp_sn, :fcp_pc, :created_at,
              :updated_at
json.url icms_url(icms, format: :json)
