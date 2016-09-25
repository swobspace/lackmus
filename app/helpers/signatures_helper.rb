module SignaturesHelper
 def signature_action_link(sig)
    link  = ""
    link += %Q[<div style="min-width:70px;">]
    link += %Q[ <div class="btn-group">]
    link +=       show_link(sig)
    link += %Q[  <button type="button" class="btn dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">]
    link += %Q[   <span class="caret"></span>]
    link += %Q[   <span class="sr-only">Toggle Dropdown</span>]
    link += %Q[  </button>]
    link += %Q[  <ul class="dropdown-menu autowidth pull-right" style="min-width:0px;">]
    if can? :edit, sig
      link += %Q[<li> #{edit_link(sig)}</li>]
    end
    if can? :destroy, Event.new
      link += %Q[<li>#{mark_events_done_link(sig)}</li>]
      link += %Q[<li>#{delete_events_link(sig)}</li>]
    end
    link += %Q[<li>#{link_to image_tag("wireshark.png"), pcap_signature_path(sig),
                       class: 'btn btn-default', title: "Download pcap file" }</li>]
    link += %Q[  </ul>]
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

  def delete_events_link(sig)
    link_to t('actions.destroy_all'),
      destroy_events_signature_path(sig, commit: t('actions.destroy_all')),
      method: :delete,
      data: {confirm: "#{t('lackmus.really')} #{t('actions.destroy_all')}?\n\n#{t('lackmus.truly')}"},
      class: "btn btn-danger"
  end

  def mark_events_done_link(sig)
    link_to t('actions.all_done'),
      destroy_events_signature_path(sig, {commit: t('actions.all_done')}),
      method: :delete,
      data: {confirm: "#{t('lackmus.really')} #{t('actions.all_done')}?"},
      class: "btn btn-warning"
  end
end
