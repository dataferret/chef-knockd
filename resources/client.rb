#
# Cookbook Name:: knockd
# Resource:: client
#
# Copyright 2014-2016 Nephila Graphic, Li-Te Chen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

actions :run
default_action :run

attribute :name, kind_of: String, name_attribute: true
attribute :ip, kind_of: String, required: true

attribute :sequence, kind_of: Array, required: true, callbacks: {
  'should contain port definitions matchin <port1>[:<tcp|udp>]' => lambda do |ports|
    KnockdValidator.validate_ports(ports)
  end
}

def initialize(name, run_context = nil)
  super
  @sequence = []
end

def port(rule)
  validate({ rule: rule }, rule: { kind_of: String, regex: VALID_PORT_REGEX })
  @sequence << rule
end
