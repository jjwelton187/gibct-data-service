class CreateIpedsIcAys < ActiveRecord::Migration
  def change
    create_table :ipeds_ic_ays do |t|
      # Used in the building of DataCsv
      t.string :cross, null: false
      t.integer :tuition_in_state
      t.integer :tuition_out_of_state
      t.integer :books

      # Not used in building DataCsv, but used in exporting source csv
      t.string :xtuit1
      t.integer :tuition1
      t.string :xfee1
      t.integer :fee1
      t.string :xhrchg1
      t.integer :hrchg1
      t.string :xtuit2
      t.integer :tuition2
      t.string :xfee2
      t.integer :fee2
      t.string :xhrchg2
      t.integer :hrchg2
      t.string :xtuit3
      t.integer :tuition3
      t.string :xfee3
      t.integer :fee3
      t.string :xhrchg3
      t.integer :hrchg3
      t.string :xtuit5
      t.integer :tuition5
      t.string :xfee5
      t.integer :fee5
      t.string :xhrchg5
      t.integer :hrchg5
      t.string :xtuit6
      t.integer :tuition6
      t.string :xfee6
      t.integer :fee6
      t.string :xhrchg6
      t.integer :hrchg6
      t.string :xtuit7
      t.integer :tuition7
      t.string :xfee7
      t.integer :fee7
      t.string :xhrchg7
      t.integer :hrchg7
      t.string :xispro1
      t.integer :isprof1
      t.string :xispfe1
      t.integer :ispfee1
      t.string :xospro1
      t.integer :osprof1
      t.string :xospfe1
      t.integer :ospfee1
      t.string :xispro2
      t.integer :isprof2
      t.string :xispfe2
      t.integer :ispfee2
      t.string :xospro2
      t.integer :osprof2
      t.string :xospfe2
      t.integer :ospfee2
      t.string :xispro3
      t.integer :isprof3
      t.string :xispfe3
      t.integer :ispfee3
      t.string :xospro3
      t.integer :osprof3
      t.string :xospfe3
      t.integer :ospfee3
      t.string :xispro4
      t.integer :isprof4
      t.string :xispfe4
      t.integer :ispfee4
      t.string :xospro4
      t.integer :osprof4
      t.string :xospfe4
      t.integer :ospfee4
      t.string :xispro5
      t.integer :isprof5
      t.string :xispfe5
      t.integer :ispfee5
      t.string :xospro5
      t.integer :osprof5
      t.string :xospfe5
      t.integer :ospfee5
      t.string :xispro6
      t.integer :isprof6
      t.string :xispfe6
      t.integer :ispfee6
      t.string :xospro6
      t.integer :osprof6
      t.string :xospfe6
      t.integer :ospfee6
      t.string :xispro7
      t.integer :isprof7
      t.string :xispfe7
      t.integer :ispfee7
      t.string :xospro7
      t.integer :osprof7
      t.string :xospfe7
      t.integer :ospfee7
      t.string :xispro8
      t.integer :isprof8
      t.string :xispfe8
      t.integer :ispfee8
      t.string :xospro8
      t.integer :osprof8
      t.string :xospfe8
      t.integer :ospfee8
      t.string :xispro9
      t.integer :isprof9
      t.string :xispfe9
      t.integer :ispfee9
      t.string :xospro9
      t.integer :osprof9
      t.string :xospfe9
      t.integer :ospfee9
      t.string :xchg1at0
      t.integer :chg1at0
      t.string :xchg1af0
      t.integer :chg1af0
      t.string :xchg1ay0
      t.integer :chg1ay0
      t.string :xchg1at1
      t.integer :chg1at1
      t.string :xchg1af1
      t.integer :chg1af1
      t.string :xchg1ay1
      t.integer :chg1ay1
      t.string :xchg1at2
      t.integer :chg1at2
      t.string :xchg1af2
      t.integer :chg1af2
      t.string :xchg1ay2
      t.integer :chg1ay2
      t.string :xchg1at3
      t.integer :chg1at3
      t.string :xchg1af3
      t.integer :chg1af3
      t.string :xchg1ay3
      t.integer :chg1ay3
      t.integer :chg1tgtd
      t.integer :chg1fgtd
      t.string :xchg2at0
      t.integer :chg2at0
      t.string :xchg2af0
      t.integer :chg2af0
      t.string :xchg2ay0
      t.integer :chg2ay0
      t.string :xchg2at1
      t.integer :chg2at1
      t.string :xchg2af1
      t.integer :chg2af1
      t.string :xchg2ay1
      t.integer :chg2ay1
      t.string :xchg2at2
      t.integer :chg2at2
      t.string :xchg2af2
      t.integer :chg2af2
      t.string :xchg2ay2
      t.integer :chg2ay2
      t.string :xchg2at3
      t.integer :chg2at3
      t.string :xchg2af3
      t.integer :chg2af3
      t.string :xchg2ay3
      t.integer :chg2tgtd
      t.integer :chg2fgtd
      t.string :xchg3at0
      t.integer :chg3at0
      t.string :xchg3af0
      t.integer :chg3af0
      t.string :xchg3ay0
      t.integer :chg3ay0
      t.string :xchg3at1
      t.integer :chg3at1
      t.string :xchg3af1
      t.integer :chg3af1
      t.string :xchg3ay1
      t.integer :chg3ay1
      t.string :xchg3at2
      t.integer :chg3at2
      t.string :xchg3af2
      t.integer :chg3af2
      t.string :xchg3ay2
      t.integer :chg3ay2
      t.string :xchg3at3
      t.integer :chg3at3
      t.string :xchg3af3
      t.integer :chg3af3
      t.string :xchg3ay3
      t.integer :chg3tgtd
      t.integer :chg3fgtd
      t.string :xchg4ay0
      t.integer :chg4ay0
      t.string :xchg4ay1
      t.integer :chg4ay1
      t.string :xchg4ay2
      t.integer :chg4ay2
      t.string :xchg4ay3
      t.string :xchg5ay0
      t.integer :chg5ay0
      t.string :xchg5ay1
      t.integer :chg5ay1
      t.string :xchg5ay2
      t.integer :chg5ay2
      t.string :xchg5ay3
      t.integer :chg5ay3
      t.string :xchg6ay0
      t.integer :chg6ay0
      t.string :xchg6ay1
      t.integer :chg6ay1
      t.string :xchg6ay2
      t.integer :chg6ay2
      t.string :xchg6ay3
      t.integer :chg6ay3
      t.string :xchg7ay0
      t.integer :chg7ay0
      t.string :xchg7ay1
      t.integer :chg7ay1
      t.string :xchg7ay2
      t.integer :chg7ay2
      t.string :xchg7ay3
      t.integer :chg7ay3
      t.string :xchg8ay0
      t.integer :chg8ay0
      t.string :xchg8ay1
      t.integer :chg8ay1
      t.string :xchg8ay2
      t.integer :chg8ay2
      t.string :xchg8ay3
      t.integer :chg8ay3
      t.string :xchg9ay0
      t.integer :chg9ay0
      t.string :xchg9ay1
      t.integer :chg9ay1
      t.string :xchg9ay2
      t.integer :chg9ay2
      t.string :xchg9ay3
      t.integer :chg9ay3
      t.timestamps null: false
    end
  end
end