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
    if can? :destroy, sig
      link += %Q[<li>#{delete_link(sig)}</li>]
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
end
