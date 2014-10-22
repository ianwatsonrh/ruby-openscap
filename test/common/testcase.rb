#
# Copyright (c) 2014 Red Hat Inc.
#
# This software is licensed to you under the GNU General Public License,
# version 2 (GPLv2). There is NO WARRANTY for this software, express or
# implied, including the implied warranties of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2
# along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
#

require 'test/unit'

module OpenSCAP
  class TestCase < Test::Unit::TestCase
    def setup
      workdir = "test/output"
      if Dir.pwd.end_with? 'test/output'
        cleanup # Older TestCase do not run cleanup method.
      end
      FileUtils.rm_rf workdir
      Dir.mkdir workdir
      Dir.chdir workdir
      @s = nil
      OpenSCAP.oscap_init
    end

    def cleanup
      @s.destroy if @s
      Dir.chdir "../.."
      OpenSCAP.raise! if OpenSCAP.error?
      OpenSCAP.oscap_cleanup
    end

    def test_x
    end
  end
end
