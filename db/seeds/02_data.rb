require 'seed_utils'

if ENV['CI'].blank?

  user = User.first

  puts 'Deleting old uploads data'
  Upload.delete_all

  puts 'Deleting old Versioned SCOs'
  VersionedSchoolCertifyingOfficial.delete_all

  puts 'Deleting old Caution Flags'
  CautionFlag.delete_all

  puts 'Deleting old institutions'
  Institution.delete_all

  puts 'Deleting old institution programs'
  InstitutionProgram.delete_all

  puts 'Deleting old zipcode rates'
  ZipcodeRate.delete_all

  puts 'Deleting old constants'
  CalculatorConstant.delete_all

  puts 'Deleting old crosswalk issues'
  CrosswalkIssue.delete_all

  puts 'Deleting old versions'
  Version.delete_all

  puts 'Loading CSVs, why not go get a nice cup of coffee while you wait? ... '
  SeedUtils.seed_table_with_upload(CalculatorConstant, user)
  SeedUtils.seed_table_with_upload(Program, user)
  SeedUtils.seed_table_with_upload(Sec109ClosedSchool, user)
  SeedUtils.seed_table_with_upload(Weam, user)
  SeedUtils.seed_table_with_upload(Crosswalk, user)
  SeedUtils.seed_table_with_upload(EightKey, user, skip_lines: 0)
  SeedUtils.seed_table_with_upload(AccreditationAction, user)
  SeedUtils.seed_table_with_upload(AccreditationRecord, user)
  SeedUtils.seed_table_with_upload(AccreditationInstituteCampus, user)
  SeedUtils.seed_table_with_upload(ArfGiBill, user)
  SeedUtils.seed_table_with_upload(Scorecard, user)
  SeedUtils.seed_table_with_upload(P911Tf, user)
  SeedUtils.seed_table_with_upload(P911Yr, user)
  SeedUtils.seed_table_with_upload(Vsoc, user)
  SeedUtils.seed_table_with_upload(Sva, user)
  SeedUtils.seed_table_with_upload(Sec702, user)
  SeedUtils.seed_table_with_upload(Sec702School, user)
  SeedUtils.seed_table_with_upload(Mou, user, skip_lines: 0)
  SeedUtils.seed_table_with_upload(Hcm, user, skip_lines: 0)
  SeedUtils.seed_table_with_upload(Settlement, user)
  SeedUtils.seed_table_with_upload(IpedsIc, user)
  SeedUtils.seed_table_with_upload(IpedsIcAy, user)
  SeedUtils.seed_table_with_upload(IpedsIcPy, user)
  SeedUtils.seed_table_with_upload(IpedsHd, user)
  SeedUtils.seed_table_with_upload(Complaint, user, skip_lines: 0)
  SeedUtils.seed_table_with_upload(Outcome, user)
  SeedUtils.seed_table_with_upload(IpedsCipCode, user)
  SeedUtils.seed_table_with_upload(StemCipCode, user)
  SeedUtils.seed_table_with_upload(YellowRibbonProgramSource, user)
  SeedUtils.seed_table_with_upload(SchoolClosure, user)
  SeedUtils.seed_table_with_upload(SchoolCertifyingOfficial, user)
  SeedUtils.seed_table_with_upload(EduProgram, user)
  SeedUtils.seed_table_with_upload(Sec103, user)
end


