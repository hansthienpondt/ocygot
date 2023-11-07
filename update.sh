#!/bin/bash

# Hack to ensure that if we are running on OS X with a homebrew installed
# GNU sed then we can still run sed.
runsed() {
  if hash gsed 2>/dev/null; then
    gsed "$@"
  else
    sed "$@"
  fi
}

git clone https://github.com/openconfig/public.git

generator -path=public -output_dir=. \
  -base_import_path=github.com/hansthienpondt/ocygot \
  -generate_path_structs \
  -package_name=ocygot -generate_fakeroot -fakeroot_name=device -compress_paths=true \
	-structs_split_files_count=20 \
  -path_structs_split_files_count=20 \
	-logtostderr \
  -shorten_enum_leaf_names \
  -trim_enum_openconfig_prefix \
  -typedef_enum_with_defmod \
  -enum_suffix_for_simple_union_enums \
  -exclude_modules=ietf-interfaces \
  -generate_rename \
  -generate_append \
  -generate_getters \
	-generate_delete \
  -generate_leaf_getters \
  -generate_populate_defaults \
  -generate_simple_unions \
  -annotations \
  -list_builder_key_threshold=3 \
	-include_schema \
	-include_model_data \
	-ignore_unsupported \
  public/release/models/acl/openconfig-acl.yang \
  public/release/models/aft/openconfig-aft.yang \
  public/release/models/aft/openconfig-aft-network-instance.yang \
  public/release/models/bfd/openconfig-bfd.yang \
  public/release/models/bgp/openconfig-bgp.yang \
  public/release/models/bgp/openconfig-bgp-policy.yang \
  public/release/models/defined-sets/openconfig-defined-sets.yang \
  public/release/models/ethernet-segments/openconfig-ethernet-segments.yang \
  public/release/models/flex-algo/openconfig-flexalgo.yang \
  public/release/models/gribi/openconfig-gribi.yang \
  public/release/models/interfaces/openconfig-interfaces.yang \
  public/release/models/interfaces/openconfig-if-ip.yang \
  public/release/models/interfaces/openconfig-if-ip-ext.yang \
  public/release/models/interfaces/openconfig-if-aggregate.yang \
  public/release/models/interfaces/openconfig-if-ethernet.yang \
  public/release/models/interfaces/openconfig-if-ethernet-ext.yang \
  public/release/models/isis/openconfig-isis.yang \
  public/release/models/keychain/openconfig-keychain.yang \
  public/release/models/lacp/openconfig-lacp.yang \
  public/release/models/lldp/openconfig-lldp.yang \
  public/release/models/local-routing/openconfig-local-routing.yang \
  public/release/models/macsec/openconfig-macsec.yang \
  public/release/models/mpls/openconfig-mpls.yang \
  public/release/models/multicast/openconfig-igmp.yang \
  public/release/models/multicast/openconfig-pim.yang \
  public/release/models/network-instance/openconfig-network-instance.yang \
  public/release/models/optical-transport/openconfig-optical-amplifier.yang \
  public/release/models/optical-transport/openconfig-terminal-device.yang \
  public/release/models/optical-transport/openconfig-transport-line-protection.yang \
  public/release/models/ospf/openconfig-ospfv2.yang \
  public/release/models/ospf/openconfig-ospf-policy.yang \
  public/release/models/pcep/openconfig-pcep.yang \
  public/release/models/platform/openconfig-platform.yang \
  public/release/models/policy-forwarding/openconfig-policy-forwarding.yang \
  public/release/models/policy/openconfig-routing-policy.yang \
  public/release/models/probes/openconfig-probes.yang \
  public/release/models/qos/openconfig-qos.yang \
  public/release/models/relay-agent/openconfig-relay-agent.yang \
  public/release/models/rib/openconfig-rib-bgp.yang \
  public/release/models/sampling/openconfig-sampling.yang \
  public/release/models/segment-routing/openconfig-segment-routing.yang \
  public/release/models/stp/openconfig-spanning-tree.yang \
  public/release/models/system/openconfig-system.yang \
  public/release/models/telemetry/openconfig-telemetry.yang \
  public/release/models/vlan/openconfig-vlan.yang

goimports -w enum.go
goimports -w enum_map.go
goimports -w schema.go
goimports -w structs-*.go
goimports -w path_structs-*.go
goimports -w union.go
rm -rf public