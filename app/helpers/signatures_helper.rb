module SignaturesHelper
 def signature_action_link(sig)
    link  = ""
    link += %Q[<div style="min-width:70px;">]
    link += %Q[ <div class="btn-group" role="group">]
    link +=       show_link(sig)
    link += %Q[  <button id="SigActionLinkDrop" type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">]
    link += %Q[  </button>]
    link += %Q[  <div class="dropdown-menu dropdown-menu-right" aria-labelledby="SigActionLinkDrop">]
    if can? :edit, sig
      link += link_to raw("<i class='fas fa-fw fa-pencil-alt'></i> #{t('actions.edit', model: t('activerecord.models.signature'))}"), edit_signature_path(sig), class: 'dropdown-item'
    end
    if can? :destroy, Event.new
      link += mark_events_done_link(sig)
      link += delete_events_link(sig)
    end
    link += link_to raw("#{icon_download} #{t('lackmus.wireshark')}") , pcap_signature_path(sig),
                    class: 'dropdown-item', title: t('lackmus.wireshark')
    link += %Q[  </div>]
    link += %Q[ </div> ]
    link += %Q[</div>]
    link.html_safe
  end

  def signature_id_link(signature)
    sig = Signature.where(signature_id: signature).first
    if sig.present?
      link_to(signature, signature_path(sig))
    else
      "#{signature}"
    end
  end

  def signatures_by_ip(ip)
    link_to("#{ip}", signatures_path(ip: ip)) + " " +
    host_report_link(ip)
  end

  def delete_events_link(sig, options = {})
    link_to raw("<i class='fas fa-fw fa-trash'></i> #{t('actions.destroy_all')}"),
      destroy_events_signature_path(sig, commit: t('actions.destroy_all')),
      method: :delete,
      data: {confirm: "#{t('lackmus.really')} #{t('actions.destroy_all')}?\n\n#{t('lackmus.truly')}"},
      class: options.fetch(:class, "dropdown-item")
  end

  def mark_events_done_link(sig, options = {})
    link_to raw("<i class='fas fa-fw fa-check'></i> #{t('actions.all_done')}"),
      destroy_events_signature_path(sig, {commit: t('actions.all_done')}),
      method: :delete,
      data: {confirm: "#{t('lackmus.really')} #{t('actions.all_done')}?"},
      class: options.fetch(:class, "dropdown-item")
  end
end
